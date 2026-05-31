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
        let countdownLocale: Locale
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

            var components = Locale.Components(locale: locale)
            // Countdown language: an explicit pick overrides, `.automatic` (nil code) skips this step
            if let code = settings.language.languageCode {
                components.languageComponents.languageCode = Locale.LanguageCode(code)
            }
            // Numerals: an explicit pick overrides; `.automatic` falls back to the locale's own
            // numbering system (UAE → Latin, Egypt → Arabic).
            components.numberingSystem = settings.typography.numeralSystem.numberingSystem ?? locale.numberingSystem
            // I need resolvedLocale because isNeedFixLabelSize's closure capture it, instead of self.countdownLocale
            let resolvedLocale = Locale(components: components)
            countdownLocale = resolvedLocale
            // Bigger label ratio only for scripts without capitals (Arabic/Hebrew/Farsi), keyed off
            // the *resolved* countdown locale — explicit pick or an automatic non-Latin Mac region.
            let localeID = resolvedLocale.identifier.lowercased()
            isNeedFixLabelSize = UIModel.nonCapitalizedLanguageCodes.contains { localeID.hasPrefix($0) }
        }
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

    static func formattedLabels(_ value: LocalizedStringResource, in locale: Locale) -> String {
        var localizedValue = value
        localizedValue.locale = locale
        return String(localized: localizedValue)
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
        allLanguages.filter { language in
            guard let code = language.languageCode else { return false }
            return preferredLanguagesCodes.contains(code)
        }
    }
    static var otherLanguages: [AppLanguage] {
        allLanguages.filter { !preferredLanguages.contains($0) }
    }
}

private extension UIModel {
    static var nonCapitalizedLanguageCodes: [String] { ["ar", "he", "fa"] }
    static var allLanguages: [AppLanguage] { AppLanguage.allCases.filter { $0 != .automatic } }
    static var allLanguagesCodes: [String] { allLanguages.compactMap { $0.languageCode } }
    static var systemPreferredCodes: [String] {
        Locale.preferredLanguages.compactMap { $0.components(separatedBy: "-").first }
    }
    static var preferredLanguagesCodes: [String] { systemPreferredCodes.filter { allLanguagesCodes.contains($0) } }
}
