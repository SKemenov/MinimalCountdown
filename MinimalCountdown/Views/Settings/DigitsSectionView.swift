//
//  DigitsSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct DigitsSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Digits.title) {
            weightPicker
            Divider()
            roundedToggle
            Divider()
            effectPicker
            Divider()
            if settings.theme.effect == .glow {
                effectColorPicker
                Divider()
            }
            numeralsPicker
        }
    }
}

private extension DigitsSectionView {
    var weightPicker: some View {
        Picker(selection: $settings.typography.weight) {
            ForEach(FontWeight.allCases) { weight in
                Text(weight.label).tag(weight)
            }
        } label: {
            Group {
                Text(Resources.Digits.weight)
                innerGlowWeightWarning
                glowWeightWarning
            }
            .accessibilityHidden(true)
        }
        .pickerStyle(.menu)
        .hint(Resources.Digits.weightHint)
        // TODO: - use `.accessibilityHint(_,isEnabled)` instead, after migrating saver target to macOS 15+
        .accessibilityLabel(weightPickerLabelText)
//        .accessibilityLabel(Text(Resources.Digits.weight))
//        .accessibilityHint(
//            Text(Resources.Theme.glowWeightWarning),
//            isEnabled: settings.theme.effect == .glow && settings.typography.weight >= .bold
//        )
//        .accessibilityHint(
//            Text(Resources.Theme.innerGlowWeightWarning),
//            isEnabled: settings.theme.effect == .innerGlow && settings.typography.weight < .regular
//        )
    }

    var weightPickerLabelText: Text {
        let mainLabel = String(localized: Resources.Digits.weight)
        let conditionalLabel: String
        if settings.theme.effect == .glow && settings.typography.weight >= .bold {
            conditionalLabel = String(localized: Resources.Theme.glowWeightWarning)
        } else if settings.theme.effect == .innerGlow && settings.typography.weight < .regular {
            conditionalLabel = String(localized: Resources.Theme.innerGlowWeightWarning)
        } else {
            conditionalLabel = String()
        }
        if conditionalLabel.isEmpty {
            return .init(verbatim: mainLabel)
        } else {
            return .init(verbatim: "\(mainLabel), \(conditionalLabel)")
        }
    }

    var roundedToggle: some View {
        Toggle(isOn: $settings.typography.isRounded) {
            Group {
                Text(Resources.Digits.rounded)
                roundedWarning
            }
            .accessibilityHidden(true)
        }
        .hint(Resources.Digits.roundedHint)
        // TODO: - use `.accessibilityHint(_,isEnabled)` instead, after migrating saver target to macOS 15+
        .accessibilityLabel(roundedToggleLabelText)
//        .accessibilityHint(
//            Text(Resources.Theme.blurRoundedWarning),
//            isEnabled: settings.theme.effect == .blur && !settings.typography.isRounded
//        )
    }

    var roundedToggleLabelText: Text {
        let mainLabel = String(localized: Resources.Digits.rounded)
        if settings.theme.effect == .blur && !settings.typography.isRounded {
            return .init(verbatim: "\(mainLabel), \(String(localized: Resources.Theme.blurRoundedWarning))")
        } else {
            return .init(verbatim: mainLabel)
        }
    }

    var effectPicker: some View {
        Picker(selection: $settings.theme.effect) {
            ForEach(EffectStyle.allCases) { effect in
                Text(effect.label).tag(effect)
                if effect == .none {
                    Divider()
                }
            }
        } label: {
            Text(Resources.Theme.effect)
                .accessibilityHidden(true)
        }
        .pickerStyle(.menu)
        .hint(UIModel.effectsHint)
        // TODO: - use `.accessibilityHint(_,isEnabled)` instead, after migrating saver target to macOS 15+
        .accessibilityLabel(effectPickerLabelText)
//        .accessibilityLabel(Text(Resources.Theme.effect))
//        .accessibilityHint(
//            Text("\(Resources.Digits.rounded), \(Resources.Theme.blurRoundedWarning)"),
//            isEnabled: settings.theme.effect == .blur && !settings.typography.isRounded
//        )
//        .accessibilityHint(
//            Text("⚠️ Additional pop-up menu Effect Color available for Glow effect"),
//            isEnabled: settings.theme.effect == .glow
//        )
//        .accessibilityHint(
//            Text("\(Resources.Digits.weight), \(Text(Resources.Theme.glowWeightWarning))"),
//            isEnabled: settings.theme.effect == .glow && settings.typography.weight >= .bold
//        )
//        .accessibilityHint(
//            Text("\(Resources.Digits.weight), \(Resources.Theme.innerGlowWeightWarning)"),
//            isEnabled: settings.theme.effect == .innerGlow && settings.typography.weight < .regular
//        )
    }

    var effectPickerLabelText: Text {
        let mainLabel = String(localized: Resources.Theme.effect)
        let conditionalLabel: String
        if settings.theme.effect == .blur && !settings.typography.isRounded {
            conditionalLabel = String(localized: Resources.Digits.rounded) + ", " + String(localized: Resources.Theme.blurRoundedWarning)
        } else if settings.theme.effect == .innerGlow && settings.typography.weight < .regular {
            conditionalLabel = String(localized: Resources.Digits.weight) + ", " + String(localized: Resources.Theme.innerGlowWeightWarning)
        } else if settings.theme.effect == .glow && settings.typography.weight >= .bold {
            conditionalLabel = String(localized: Resources.Digits.weight) + ", " + String(localized: Resources.Theme.glowWeightWarning)
        } else if settings.theme.effect == .glow {
            conditionalLabel = String(localized: Resources.Theme.effectColorHint)
        } else {
            conditionalLabel = String()
        }
        if conditionalLabel.isEmpty {
            return .init(verbatim: mainLabel)
        } else {
            return .init(verbatim: "\(mainLabel), \(conditionalLabel)")
        }
    }

    var effectColorPicker: some View {
        Picker(selection: $settings.theme.effectColor) {
            ForEach(AccentColor.allCases) { color in
                showColor(color).tag(color)
            }
        } label: {
            Text(Resources.Theme.effectColor)
        }
        .pickerStyle(.menu)
        .accessibilityElement(children: .ignore)
        .accessibilityRepresentation {
            Picker(selection: $settings.theme.effectColor) {
                ForEach(AccentColor.allCases) { color in
                    Text(color.label).tag(color)
                }
            } label: {
                Text(Resources.Theme.effectColor)
                    .accessibilityHidden(true)
            }
            .pickerStyle(.menu)
            .accessibilityLabel(Text(Resources.Theme.effectColor))
        }
    }

    var numeralsPicker: some View {
        Picker(selection: $settings.typography.numeralSystem) {
            ForEach(NumeralSystem.allCases) { system in
                Text(numeralRow(system)).tag(system)
                if system == .automatic {
                    Divider()
                }
            }
        } label: {
            Text(Resources.Digits.numerals)
                .accessibilityHidden(true)
        }
        .pickerStyle(.menu)
        .hint(Resources.Digits.numeralsHint)
        .accessibilityLabel(Text(Resources.Digits.numerals))
    }

    /// `● Label` row for a color Picker. An AttributedString keeps the dot's color in the
    /// pop-up menu; the label stays default-colored.
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

    @ViewBuilder
    var roundedWarning: some View {
        if settings.theme.effect == .blur && !settings.typography.isRounded {
            Text(Resources.Theme.blurRoundedWarning)
                .subtitleFont
        }
    }

    /// Effect-driven font warnings, shown on the Font controls the user would adjust.
    @ViewBuilder
    var innerGlowWeightWarning: some View {
        if settings.theme.effect == .innerGlow && settings.typography.weight < .regular {
            Text(Resources.Theme.innerGlowWeightWarning)
                .subtitleFont
        }
    }

    /// Effect-driven font warnings, shown on the Font controls the user would adjust.
    @ViewBuilder
    var glowWeightWarning: some View {
        if settings.theme.effect == .glow && settings.typography.weight >= .bold {
            Text(Resources.Theme.glowWeightWarning)
                .subtitleFont
        }
    }
}

#Preview {
    DigitsSectionView(settings: .constant(.default))
}
