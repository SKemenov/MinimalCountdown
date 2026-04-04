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
            .onKeyPress(.return, action: saveByEnterKey)

            buttons
        }
        .frame(width: 512, height: 740 + 48)
        .onAppear { settings = settingsManager.settings }
        .task(setTitleFocused)
    }
}

private extension ConfigurationWindow {
    var appearanceSection: some View {
        Section() {
            AppearancePicker("Appearance", currentSettings: $settings)
        }
    }

    var dateSection: some View {
        Section("Date") {
            DatePicker(
                selection: $settings.targetDate,
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
            DatePicker(selection: $settings.targetDate, displayedComponents: .hourAndMinute) {
                Text("Time")
                Text("By default it will be set to midnight")
            }
        }
    }

    
    var themeSection: some View {
        Section("Theme") {
            ColorPalettePicker("Color", selection: $settings.color)

            Toggle(isOn: $settings.isBrightNormal) {
                Text("Bright colors")
                Text("Make digits and text brighter")
            }

            if let extra = settings.isExtra, extra == true {
                if #available (macOS 15.0, *) {
                    Picker("Background", selection: $settings.backgroundColor) {
                        ForEach(BackgroundColor.allCases) { option in
                            showColor(option)
                                .disabled(option != .black)
                        }
                    } currentValueLabel: {
                        showColor(settings.backgroundColor)
                    }
                    .disabled(true)
                } else {
                    Picker("Background", selection: $settings.backgroundColor) {
                        ForEach(BackgroundColor.allCases) { option in
                            showColor(option)
                                .disabled(option != .black)
                        }
                    }
                    .disabled(true)
                }

                Picker(selection: $settings.style) {
                    Text("Glow").tag(0)
                    Text("Shadow").tag(1)
                    Text("None").tag(2)
                } label: {
                    Text("Additional effects")
                    Text("Apply glow or shadow to digits and text")
                }
                .pickerStyle(.inline)
                .disabled(true)
            }
        }
    }

    var titleSection: some View {
        Section("Title") {
            TextField("", text: $settings.message, prompt: Text("Add your message here"))
                .focused($focus, equals: .title)

            Toggle(isOn: $settings.isMessageHidden) {
                Text("Hide title")
                Text("Even title is not empty")
            }
            .help("Hide title, even it's not empty")
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

    func setTitleFocused() async {
        try? await Task.sleep(for: .seconds(0.01))
        focus = .title
    }

    @discardableResult
    func saveByEnterKey() -> KeyPress.Result {
        saveAndExit()
        return .handled
    }

    func saveAndExit() {
        logger.log("Saving and closing configuration sheet")
        settingsManager.save(settings)
        if let onClose {
            logger.log("Run onClose callback to close configuration sheet")
            onClose()
        } else {
            logger.log("Dismiss SwiftUI window")
            dismiss()
        }
    }

    func showColor(_ option: BackgroundColor) -> some View {
        let icon = Image(systemName: "circle.fill")
        let iconText = Text(icon).foregroundStyle(option.color)
        return Text("\(iconText) \(option.name)").backgroundStyle(.secondary)
    }
}

#Preview("Light mode") {
    ConfigurationWindow()
        .environment(SettingsManager(stores: []))
        .preferredColorScheme(.light)
}
#Preview("Dark mode") {
    ConfigurationWindow()
        .environment(SettingsManager(stores: []))
        .preferredColorScheme(.dark)
}
