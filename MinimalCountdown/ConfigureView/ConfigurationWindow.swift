//
//  ConfigurationWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import OSLog
import SwiftUI

struct ConfigurationWindow: View {
    private enum FocusTarget: Hashable { case title }

    private let logger: Logger
    var onClose: (() -> Void)?

    @State private var settings: SaverSettings = .default
    @State private var saveError: String?
    @State private var dismissTask: Task<Void, Never>?
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focus: FocusTarget?

    init(onClose: (() -> Void)? = nil) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        self.onClose = onClose
    }

    var body: some View {
        VStack(spacing: .zero) {
            Form {
                appearanceSection
                dateSection
                themeSection
                titleSection
            }
            .formStyle(.grouped)
            .animation(.default, value: settings)
            .onKeyPress(.return, action: saveByEnterKey)

            errorMessage

            buttons
        }
        .frame(width: 512, height: 740 + 48)
        .animation(.default, value: saveError)
        .onAppear(perform: prepareForDisplay)
        .task(setTitleFocused)
    }
}

private extension ConfigurationWindow {
    var appearanceSection: some View {
        Section(Resources.Copy.Appearance.title) {
            AppearancePicker(Resources.Copy.Appearance.style, selection: $settings.appearance, in: settings)
            Toggle(isOn: $settings.appearance.isLabelHidden) {
                Text(Resources.Copy.Appearance.hideLabels)
                Text(Resources.Copy.Appearance.hideLabelsHint)
            }
            .help(Resources.Copy.Appearance.hideLabelsHint)
            Text(Resources.Copy.Appearance.previewHint)
                .subtitleFont
        }
    }

    var dateSection: some View {
        Section(Resources.Copy.Date.title) {
            DatePicker(selection: $settings.schedule.target, displayedComponents: .hourAndMinute) {
                Text(Resources.Copy.Date.time)
                Text(Resources.Copy.Date.timeHint)
            }
            .help(Resources.Copy.Date.timeHint)
            DatePicker(
                selection: $settings.schedule.target,
                in: Date.now.datesInBetween(),
                displayedComponents: .date
            ) {
                Text(Resources.Copy.Date.day)
                VStack(alignment: .leading) {
                    Text(Resources.Copy.Date.dayHint1)
                    Text(Resources.Copy.Date.dayHint2)
                    Text(Resources.Copy.Date.dayHint3)
                }
            }
            .datePickerStyle(.graphical)
        }
    }

    
    var themeSection: some View {
        Section(Resources.Copy.Theme.title) {
            ColorPalettePicker(Resources.Copy.Theme.color, selection: $settings.theme.accent)
            BrightnessPicker(Resources.Copy.Theme.brightness, selection: $settings.theme.brightness)
        }
    }

    var titleSection: some View {
        Section(Resources.Copy.Title.title) {
            TextField("", text: $settings.title.text, prompt: Text(Resources.Copy.Title.messagePrompt))
                .focused($focus, equals: .title)

            Toggle(isOn: $settings.title.isHidden) {
                Text(Resources.Copy.Title.hideTitle)
                Text(Resources.Copy.Title.hideTitleHint)
            }
            .help(Resources.Copy.Title.hideTitleHint)
        }
    }

    @ViewBuilder
    var errorMessage: some View {
        if let saveError {
            Text(saveError)
                .foregroundStyle(.red)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .transition(.asymmetric(insertion: .opacity, removal: .identity))
        }
    }

    var buttons: some View {
        HStack {
            Spacer()
            Button(action: saveAndExit) {
                Text(Resources.Copy.Buttons.close)
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

    func setTitleFocused() async {
        try? await Task.sleep(for: .seconds(0.01))
        focus = .title
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

private extension View {
    var subtitleFont: some View {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
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
