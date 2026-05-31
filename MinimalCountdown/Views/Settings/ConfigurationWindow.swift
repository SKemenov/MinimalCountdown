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
                digitsSection
                titleSection
                languageSection
            }
            .formStyle(.grouped)
            .animation(.default, value: settings)
            .onKeyPress(.return, action: saveByEnterKey)

            languageWarning
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
        Section {
            AppearancePicker(selection: $settings.appearance, in: settings)

            Toggle(isOn: $settings.appearance.isLabelHidden) {
                Text(Resources.Appearance.hideLabels)
                Text(Resources.Appearance.hideLabelsHint)
                    .subtitleFont
            }
            .help(Text(Resources.Appearance.hideLabelsHint))

            Text(Resources.Appearance.previewHint)
                .subtitleFont
        } header: {
            Text(Resources.Appearance.title)
        }
    }

    var dateSection: some View {
        Section {
            DatePicker(selection: $settings.schedule.target, displayedComponents: .hourAndMinute) {
                Text(Resources.Date.time)
                Text(Resources.Date.timeHint)
                    .subtitleFont
            }
            .help(Text(Resources.Date.timeHint))

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
                        .lineLimit(5)
                }
                .subtitleFont
            }
            .datePickerStyle(.graphical)
        } header: {
            Text(Resources.Date.title)
        }
    }


    var themeSection: some View {
        Section {
            ColorPalettePicker(Resources.Theme.color, selection: $settings.theme.accent)
            BrightnessSlider(Resources.Theme.brightness, selection: $settings.theme.brightness)
        } header: {
            Text(Resources.Theme.title)
        }
    }

    var digitsSection: some View {
        Section {
            Picker(selection: $settings.typography.weight) {
                ForEach(FontWeight.allCases) { weight in
                    Text(weight.label).tag(weight)
                }
            } label: {
                Text(Resources.Digits.weight)
                Text(Resources.Digits.weightHint)
                    .subtitleFont
                if let weightWarning {
                    Text(weightWarning)
                        .subtitleFont
                }
            }
            .help(Text(Resources.Digits.weightHint))

            Toggle(isOn: $settings.typography.isRounded) {
                Text(Resources.Digits.rounded)
                Text(Resources.Digits.roundedHint)
                    .subtitleFont
                if let roundedWarning {
                    Text(roundedWarning)
                        .subtitleFont
                }
            }
            .help(Text(Resources.Digits.roundedHint))

            Picker(selection: $settings.theme.effect) {
                ForEach(EffectStyle.allCases) { effect in
                    Text(effect.label).tag(effect)
                }
            } label: {
                Text(Resources.Theme.effect)
                Text(UIModel.effectsHint)
                    .subtitleFont
            }
            .help(UIModel.effectsHint)

            if settings.theme.effect == .glow {
                Picker(selection: $settings.theme.effectColor) {
                    ForEach(AccentColor.allCases) { color in
                        showColor(color).tag(color)
                    }
                } label: {
                    Text(Resources.Theme.effectColor)
                }
            }

            Picker(selection: $settings.typography.numeralSystem) {
                ForEach(NumeralSystem.allCases) { system in
                    Text(numeralRow(system)).tag(system)
                }
            } label: {
                Text(Resources.Digits.numerals)
                Text(Resources.Digits.numeralsHint)
                    .subtitleFont
            }
            .help(Text(Resources.Digits.numeralsHint))
        } header: {
            Text(Resources.Digits.title)
        }
    }

    var titleSection: some View {
        Section {
            TextField(text: $settings.title.text, prompt: Text(Resources.Title.titlePrompt)) { Text(verbatim: "") }

            Toggle(isOn: $settings.title.isHidden) {
                Text(Resources.Title.hideTitle)
                Text(Resources.Title.hideTitleHint)
                    .subtitleFont
            }
            .help(Text(Resources.Title.hideTitleHint))
        } header: {
            Text(Resources.Title.title)
        }
    }

    var languageSection: some View {
        Section {
            Picker(selection: $settings.language) {
                Text(AppLanguage.automatic.label).tag(AppLanguage.automatic)

                if !UIModel.preferredLanguages.isEmpty {
                    ForEach(UIModel.preferredLanguages) { language in
                        Text(language.label).tag(language)
                    }
                }
                Divider()

                ForEach(UIModel.otherLanguages) { language in
                    Text(language.label).tag(language)
                }
            } label: {
                Text(Resources.Language.countdown)
                Text(Resources.Language.countdownHint)
                    .subtitleFont
            }
            .help(Text(Resources.Language.countdownHint))

            Text(Resources.Language.translationDisclaimer)
                .subtitleFont
        } header: {
            Text(Resources.Language.title)
        }
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

    /// Effect-driven font warnings, shown on the Font controls the user would adjust.
    var weightWarning: LocalizedStringResource? {
        let weight = settings.typography.weight
        if settings.theme.effect == .glow, weight >= .bold {
            return Resources.Theme.glowWeightWarning
        }
        if settings.theme.effect == .innerGlow, weight < .regular {
            return Resources.Theme.innerGlowWeightWarning
        }
        return nil
    }

    var roundedWarning: LocalizedStringResource? {
        settings.theme.effect == .blur && !settings.typography.isRounded
            ? Resources.Theme.blurRoundedWarning
            : nil
    }

    /// `● Label` row for a color Picker. An AttributedString keeps the dot's color in the
    /// pop-up menu (a Label/Image icon renders monochrome there); the label stays default-colored.
    func showColor(_ option: any ColorExtendable) -> some View {
        var row = AttributedString("●  ")
        row.foregroundColor = option.color
        row.append(AttributedString(localized: option.label))
        return Text(row)
    }

    /// Picker row: the numeral-system name + a `123` glyph sample for the explicit systems.
    /// `.automatic` shows the name only — its glyphs depend on the viewer's locale.
    func numeralRow(_ system: NumeralSystem) -> String {
        let name = String(localized: system.label)
        guard let numbering = system.numberingSystem else { return name }
        var components = Locale.Components(identifier: "en_US")
        components.numberingSystem = numbering
        return "\(name)  \(UIModel.formattedDigits(123, in: Locale(components: components)))"
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
