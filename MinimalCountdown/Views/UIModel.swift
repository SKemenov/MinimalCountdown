//
//  UIModel.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum UIModel {
    struct RenderSettings {
        let digitsColor: Color
        let textsColor: Color
        let digitsWeight: Font.Weight
        let digitsDesign: Font.Design
        let isLabelHidden: Bool
        let effect: EffectStyle
        let effectGlowColor: Color
        let digitLocale: Locale
        let isNeedFixLabelSize: Bool

        init(_ settings: SaverSettings, locale: Locale = .autoupdatingCurrent) {
            let theme = settings.theme
            digitsColor = theme.accent.color.opacity(theme.brightness.digitsOpacity)
            textsColor = theme.accent.color.opacity(theme.brightness.textsOpacity)
            digitsWeight = settings.typography.weight.swiftUIWeight
            digitsDesign = settings.typography.isRounded ? .rounded : .default
            isLabelHidden = settings.appearance.isLabelHidden
            effect = theme.effect
            // Glow dimmed by brightness, matching the digit fill: effectColor for glow, accent otherwise.
            effectGlowColor = (theme.effect == .glow ? theme.effectColor : theme.accent)
                .color.opacity(theme.brightness.digitsOpacity)

            // Numerals: an explicit pick overrides; `.automatic` falls back to the locale's own
            // numbering system (UAE → Latin, Egypt → Arabic).
            let numbering = settings.typography.numeralSystem.numberingSystem ?? locale.numberingSystem
            var components = Locale.Components(locale: locale)
            components.numberingSystem = numbering
            digitLocale = Locale(components: components)
            isNeedFixLabelSize = !nonCapitalizedLanguages.map { $0.contains(locale.identifier.lowercased()) }.isEmpty
        }

        private let nonCapitalizedLanguages = ["ar", "he", "fa"]
    }

    struct Element {
        let digits: String
        let label: String
        let size: CGFloat
        let render: RenderSettings
    }

    struct TextElement {
        let text: String
        let size: CGFloat
        let color: Color
        var weight: Font.Weight = .ultraLight
        var design: Font.Design = .default
    }

    static func formattedTitle(_ title: Title) -> String {
        guard !title.isHidden, !title.text.isEmpty else { return "" }
        let string = title.text.uppercased()
        let words = string.components(separatedBy: " ")
        let separator = string.count <= 30 ? "  " : "   "
        return words.joined(separator: separator)
    }

    /// Countdown digit string: zero-padded (min 2, grows for 3-digit day counts) and rendered
    /// in `locale`'s numeral system (the resolved `RenderSettings.digitLocale`).
    static func formattedDigits(_ value: Int, in locale: Locale) -> String {
        value.formatted(.number.precision(.integerLength(2...)).grouping(.never).locale(locale))
    }

    /// Effect-section subtitle/tooltip: the base hint + a localized "or"-list of the available
    /// effect names (lowercased).
    static var effectsHint: String {
        let effectNames = EffectStyle.allCases
            .filter { $0 != .none }
            .map { String(localized: $0.label).lowercased() }
            .formatted(.list(type: .or))
        return "\(String(localized: Resources.Theme.effectHint)) \(effectNames)"
    }

    static var preferredLanguages: [AppLanguage] {
        allLanguages.filter { preferredLanguagesCodes.contains($0.languageCode) }
    }
    static var otherLanguages: [AppLanguage] {
        allLanguages.filter { !preferredLanguages.contains($0) }
    }
}

private extension UIModel {
    static var allLanguages: [AppLanguage] { AppLanguage.allCases.filter { $0 != .automatic } }
    static var allLanguagesCodes: [String] { AppLanguage.allCases.filter { $0 != .automatic }.map { $0.languageCode } }
    static var systemPreferredCodes: [String] { Locale.preferredLanguages.map { String($0.prefix(2)) } }
    static var preferredLanguagesCodes: [String] { systemPreferredCodes.filter { allLanguagesCodes.contains($0) } }
}
