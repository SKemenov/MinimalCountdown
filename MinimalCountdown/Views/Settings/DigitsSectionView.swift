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
        Section {
            weightPicker
            roundedToggle
            effectPicker
            effectColorPicker
            numeralsPicker
        } header: {
            Text(Resources.Digits.title)
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
            Text(Resources.Digits.weight)
            innerGlowWeightWarning
            glowWeightWarning
        }
        .help(Text(Resources.Digits.weightHint))
    }

    var roundedToggle: some View {
        Toggle(isOn: $settings.typography.isRounded) {
            Text(Resources.Digits.rounded)
            roundedWarning
        }
        .help(Text(Resources.Digits.roundedHint))
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
        }
        .help(UIModel.effectsHint)
    }

    @ViewBuilder
    var effectColorPicker: some View {
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
        }
        .help(Text(Resources.Digits.numeralsHint))
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
        if settings.theme.effect == .innerGlow, settings.typography.weight < .regular {
            Text(Resources.Theme.innerGlowWeightWarning)
                .subtitleFont
        }
    }

    /// Effect-driven font warnings, shown on the Font controls the user would adjust.
    @ViewBuilder
    var glowWeightWarning: some View {
        if settings.theme.effect == .glow, settings.typography.weight >= .bold {
            Text(Resources.Theme.glowWeightWarning)
                .subtitleFont
        }
    }
}

#Preview {
    DigitsSectionView(settings: .constant(.default))
}
