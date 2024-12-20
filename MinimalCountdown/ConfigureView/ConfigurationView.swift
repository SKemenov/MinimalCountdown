//
//  ConfigurationView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI
import OSLog

struct ConfigurationView: View {
    private let logger: Logger
    var settingsManager: SettingsManager
    var onClose: (() -> Void)?

    @State private var settings: SaverSettings
    @Environment(\.dismiss) private var dismiss

    init(settingsManager: SettingsManager, onClose: (() -> Void)? = nil) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        self.onClose = onClose
        settingsManager.load()
        self.settingsManager = settingsManager
        settings = settingsManager.settings
    }

    var body: some View {
        VStack {
            Form {
                appearanceSection
                dateSection
                themeSection
                titleSection
            }
            .formStyle(.grouped)

            buttons
        }
        .frame(width: 512, height: 740)
        .onAppear(perform: onAppearAction)
    }
}

private extension ConfigurationView {
    var appearanceSection: some View {
        Section() {
            Picker(selection: $settings.style) {
                ForEach(StyleElement.allCases) {
                    Text($0.menuLabel)
                }
            } label: {
                Text("Appearance")
            }
            .pickerStyle(.palette)
        }
    }

    var dateSection: some View {
        Section("Date") {
            DatePicker(selection: $settings.targetDate, displayedComponents: .date) {
                Text("Day")
                VStack(alignment: .leading) {
                    Text("It can be any future date for Countdown Mode or any past date for Timer Mode. The available range of dates ​​is one year before the current date and one year after it.")
                    Text("When the countdown reaches zero, it automatically switch to Timer Mode and start counting up again.")
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
        }
    }

    var titleSection: some View {
        Section("Title") {
            TextField("", text: $settings.message, prompt: Text("Add your message here"))
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

    func onAppearAction() {
        logger.log("Open configuration sheet")
        settingsManager.load()
        settings = settingsManager.settings
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
    ConfigurationView(settingsManager: SettingsManager(stores: []))
        .preferredColorScheme(.light)
}
#Preview("Dark mode") {
    ConfigurationView(settingsManager: SettingsManager(stores: []))
        .preferredColorScheme(.dark)
}
