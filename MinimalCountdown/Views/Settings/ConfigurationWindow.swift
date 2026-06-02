//
//  ConfigurationWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import OSLog
import SwiftUI

// TODO: - rename to SettingsWindow
struct ConfigurationWindow: View {

    private let logger: Logger
    var onClose: (() -> Void)?

    @State private var settings: SaverSettings = .default
    @State private var saveError: String?
    @State private var dismissTask: Task<Void, Never>?
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(\.dismiss) private var dismiss

    init(onClose: (() -> Void)? = nil) {
        logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        self.onClose = onClose
    }

    var body: some View {
        VStack(spacing: .zero) {
            Form {
                AppearanceSectionView(settings: $settings)
                DateSectionView(settings: $settings)
                ThemeSectionView(settings: $settings)
                DigitsSectionView(settings: $settings)
                TitleSectionView(settings: $settings)
                LanguageSectionView(settings: $settings)
            }
            .formStyle(.grouped)
            .animation(.default, value: settings)
            .onKeyPress(.return, action: saveByEnterKey)

            languageWarning
            errorMessage
            buttons
        }
        .frame(width: .Sizes.settingsWidth, height: windowHeight)
        .animation(.default, value: saveError)
        .onAppear(perform: prepareForDisplay)
    }
}

private extension ConfigurationWindow {
    /// Fit the window to the screen: the full Form shows on large displays (no scroll); on smaller
    /// screens the window shrinks to the visible height while the Form scrolls inside — `Close` and
    /// the warnings stay pinned below. Read off the key screen once per render (settings windows
    /// don't migrate between displays mid-use).
    var windowHeight: CGFloat {
        let visibleHeight = NSScreen.main?.visibleFrame.height ?? .Sizes.settingsIdealHeight
        return min(.Sizes.settingsIdealHeight, visibleHeight - .Sizes.settingsScreenMargin)
    }

    @ViewBuilder
    var languageWarning: some View {
        if settings.language != settingsManager.settings.language {
            Text(Resources.Language.applyWarning)
                .foregroundStyle(.secondary)
                .formNote
        }
    }

    @ViewBuilder
    var errorMessage: some View {
        if let saveError {
            Text(saveError)
                .foregroundStyle(.red)
                .formNote
        }
    }

    var buttons: some View {
        HStack {
            Spacer()
            Button(action: saveAndExit) {
                Text(Resources.Buttons.close)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }

    func prepareForDisplay() {
        withAnimation(.none) {
            settings = settingsManager.settings
        }
        saveError = nil
        dismissTask?.cancel()
        dismissTask = nil
    }

    @discardableResult
    func saveByEnterKey() -> KeyPress.Result {
        saveAndExit()
        return .handled
    }

    func exitSettings() {
        if let onClose {
            logger.log("Run onClose callback to close configuration sheet")
            onClose()
        } else {
            logger.log("Dismiss SwiftUI window")
            dismiss()
        }
    }

    func saveAndExit() {
        guard saveError == nil else {
            logger.log("Close clicked while banner shown — cancelling dismiss timer and exiting")
            dismissTask?.cancel()
            exitSettings()
            return
        }
        logger.log("Saving and closing configuration sheet")
        do {
            try settingsManager.save(settings)
            exitSettings()
        } catch {
            logger.error("Save failed: \(error.localizedDescription, privacy: .public)")
            saveError = error.localizedDescription
            dismissTask = Task { @MainActor in
                try? await Task.sleep(for: .seconds(4))
                guard !Task.isCancelled else { return }
                exitSettings()
            }
        }
    }
}

#if DEBUG
#Preview("Light mode") {
    ConfigurationWindow()
        .environment(SettingsManager(saver: MockInMemoryLocalStore(initial: .preview)))
        .preferredColorScheme(.light)
}

#Preview("Dark mode") {
    ConfigurationWindow()
        .environment(SettingsManager(saver: MockInMemoryLocalStore(initial: .preview)))
        .preferredColorScheme(.dark)
}

#endif
