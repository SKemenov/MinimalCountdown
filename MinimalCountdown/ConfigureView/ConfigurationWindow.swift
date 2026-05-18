//
//  ConfigurationWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import OSLog
import SwiftUI

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
                appearanceSection
                dateSection
                themeSection
                fontSection
                titleSection
            }
            .formStyle(.grouped)
            .animation(.default, value: settings)
            .onKeyPress(.return, action: saveByEnterKey)

            errorMessage

            buttons
        }
        .frame(width: 512, height: 860 + 48)
        .animation(.default, value: saveError)
        .onAppear(perform: prepareForDisplay)
    }
}

private extension ConfigurationWindow {
    var appearanceSection: some View {
        Section(Resources.Appearance.title) {
            AppearancePicker(Resources.Appearance.style, selection: $settings.appearance, in: settings)

            Toggle(isOn: $settings.appearance.isLabelHidden) {
                Text(Resources.Appearance.hideLabels)
                Text(Resources.Appearance.hideLabelsHint)
                    .subtitleFont
            }
            .help(Resources.Appearance.hideLabelsHint)

            Text(Resources.Appearance.previewHint)
                .subtitleFont
        }
    }

    var dateSection: some View {
        Section(Resources.Date.title) {
            DatePicker(selection: $settings.schedule.target, displayedComponents: .hourAndMinute) {
                Text(Resources.Date.time)
                Text(Resources.Date.timeHint)
                    .subtitleFont
            }
            .help(Resources.Date.timeHint)

            DatePicker(
                selection: $settings.schedule.target,
                in: Date.now.datesInBetween(),
                displayedComponents: .date
            ) {
                Text(Resources.Date.day)
                VStack(alignment: .leading) {
                    Text(Resources.Date.dayHint1)
                    Text(Resources.Date.dayHint2)
                    Text(Resources.Date.dayHint3)
                }
                .subtitleFont
            }
            .datePickerStyle(.graphical)
        }
    }

    
    var themeSection: some View {
        Section(Resources.Theme.title) {
            ColorPalettePicker(Resources.Theme.color, selection: $settings.theme.accent)
            BrightnessSlider(Resources.Theme.brightness, selection: $settings.theme.brightness)

            Picker(selection: $settings.theme.effect) {
                ForEach(EffectStyle.allCases) { effect in
                    Label(effect.label, systemImage: effect.icon).tag(effect)
                }
            } label: {
                Text(Resources.Theme.effect)
                Text(Resources.Theme.effectHint)
                    .subtitleFont
            }
            .help(Resources.Theme.effectHint)

            if settings.theme.effect == .glow {
                Picker(selection: $settings.theme.effectColor) {
                    ForEach(AccentColor.allCases) { color in
                        showColor(color).tag(color)
                    }
                } label: {
                    Text(Resources.Theme.effectColor)
                }
            }
        }
    }

    var fontSection: some View {
        Section(Resources.Font.title) {
            Picker(selection: $settings.typography.weight) {
                ForEach(FontWeight.allCases) { weight in
                    Text(weight.label).tag(weight)
                }
            } label: {
                Text(Resources.Font.weight)
                Text(Resources.Font.weightHint)
                    .subtitleFont
                if let weightWarning {
                    Text(weightWarning)
                        .subtitleFont
                }
            }
            .help(Resources.Font.weightHint)

            Toggle(isOn: $settings.typography.isRounded) {
                Text(Resources.Font.rounded)
                Text(Resources.Font.roundedHint)
                    .subtitleFont
                if let roundedWarning {
                    Text(roundedWarning)
                        .subtitleFont
                }
            }
            .help(Resources.Font.roundedHint)
        }
    }

    var titleSection: some View {
        Section(Resources.Title.title) {
            TextField("", text: $settings.title.text, prompt: Text(Resources.Title.messagePrompt))

            Toggle(isOn: $settings.title.isHidden) {
                Text(Resources.Title.hideTitle)
                Text(Resources.Title.hideTitleHint)
                    .subtitleFont
            }
            .help(Resources.Title.hideTitleHint)
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
                Text(Resources.Buttons.close)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }

    /// Effect-driven font warnings, shown on the Font controls the user would adjust.
    var weightWarning: String? {
        let weight = settings.typography.weight
        if settings.theme.effect == .glow, weight >= .bold {
            return Resources.Theme.glowWeightWarning
        }
        if settings.theme.effect == .innerGlow, weight < .regular {
            return Resources.Theme.innerGlowWeightWarning
        }
        return nil
    }

    var roundedWarning: String? {
        settings.theme.effect == .blur && !settings.typography.isRounded
            ? Resources.Theme.blurRoundedWarning
            : nil
    }

    /// `● Name` row for a color Picker. An AttributedString keeps the dot's color in the
    /// pop-up menu (a Label/Image icon renders monochrome there); the name stays default-colored.
    func showColor(_ option: any ColorExtendable) -> some View {
        var row = AttributedString("●  ")
        row.foregroundColor = option.color
        row.append(AttributedString(option.name))
        return Text(row)
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
