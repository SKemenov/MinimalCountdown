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
                titleAndLabelsSection
            }
            .formStyle(.grouped)
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
        Section() {
            AppearancePicker("Appearance", selection: $settings.appearance, in: settings)
            Text("Close this window and click Preview to see all the changes in detail in full screen mode.")
                .subtitleFont
        }
    }

    var dateSection: some View {
        Section("Date") {
            DatePicker(
                selection: $settings.schedule.target,
                in: Date.now.datesInBetween(),
                displayedComponents: .date
            ) {
                Text("Day")
                VStack(alignment: .leading) {
                    Text("It can be any future date for Timer Mode or any past date for Stopwatch Mode.")
                    Text("The available range is two years from the current date.")
                    Text("When the countdown reaches zero, it automatically switches to Stopwatch Mode and starts counting up.")
                }
            }
            .datePickerStyle(.graphical)
            DatePicker(selection: $settings.schedule.target, displayedComponents: .hourAndMinute) {
                Text("Time")
                Text("By default it will be set to midnight")
            }
        }
    }

    
    var themeSection: some View {
        Section("Theme") {
            ColorPalettePicker("Color", selection: $settings.theme.accent)

            Toggle(isOn: Binding(
                get: { settings.theme.brightness == .high },
                set: { settings.theme.brightness = $0 ? .high : .medium }
            )) {
                Text("Bright colors")
                Text("Make digits and text brighter")
            }
        }
    }

    var titleAndLabelsSection: some View {
        Section("Title") {
            TextField("", text: $settings.title.text, prompt: Text("Add your message here"))
                .focused($focus, equals: .title)

            Toggle(isOn: $settings.title.isHidden) {
                Text("Hide title")
                Text("Even title is not empty")
            }
            .help("Hide title, even it's not empty")
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
                Text("Close")
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }

    func prepareForDisplay() {
        settings = settingsManager.settings
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
