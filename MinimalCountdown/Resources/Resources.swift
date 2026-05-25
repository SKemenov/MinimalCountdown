//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

private final class BundleToken {}

extension LocalizedStringResource.BundleDescription {
    /// Anchors `LocalizedStringResource` lookups to *this* bundle. Inside a `.saver`, `Bundle.main`
    /// is the host app (System Settings), so the default `.main` resolution silently falls back to
    /// the development-language key. `BundleToken` compiles into each target, so `.forClass` resolves
    /// to the saver bundle in the saver and the app bundle in DevApp.
    static let app = LocalizedStringResource.BundleDescription.forClass(BundleToken.self)
}

// MARK: - Localized UI strings
enum Resources {
    /// Single source of truth for strings that used to be derived inline via `String(describing:)`.
    /// Mirrors the model enums.
    enum Labels {
        enum AppearanceStyle {
            static let days = LocalizedStringResource("Days", bundle: .app)
            static let hours = LocalizedStringResource("Hours", bundle: .app)
            static let minutes = LocalizedStringResource("Minutes", bundle: .app)
            static let seconds = LocalizedStringResource("Seconds", bundle: .app)
        }

        enum Brightness {
            static let low = LocalizedStringResource("Low", bundle: .app)
            static let medium = LocalizedStringResource("Medium", bundle: .app)
            static let high = LocalizedStringResource("High", bundle: .app)
        }

        // Symbolic keys (with in-code `defaultValue` for the English source) so the weight labels
        // don't share a catalog entry with Brightness ("Medium") or BackgroundColor ("Black") —
        // their Russian forms differ (feminine, agreeing with "Толщина").
        enum FontWeight {
            static let ultraLight = LocalizedStringResource("Weight.ultraLight", defaultValue: "Ultra Light", bundle: .app)
            static let thin = LocalizedStringResource("Weight.thin", defaultValue: "Thin", bundle: .app)
            static let light = LocalizedStringResource("Weight.light", defaultValue: "Light", bundle: .app)
            static let regular = LocalizedStringResource("Weight.regular", defaultValue: "Regular", bundle: .app)
            static let medium = LocalizedStringResource("Weight.medium", defaultValue: "Medium", bundle: .app)
            static let semibold = LocalizedStringResource("Weight.semibold", defaultValue: "Semibold", bundle: .app)
            static let bold = LocalizedStringResource("Weight.bold", defaultValue: "Bold", bundle: .app)
            static let heavy = LocalizedStringResource("Weight.heavy", defaultValue: "Heavy", bundle: .app)
            static let black = LocalizedStringResource("Weight.black", defaultValue: "Black", bundle: .app)
        }

        enum EffectStyle {
            static let none = LocalizedStringResource("None", bundle: .app)
            static let glow = LocalizedStringResource("Glow", bundle: .app)
            static let innerGlow = LocalizedStringResource("Inner Glow", bundle: .app)
            static let backlight = LocalizedStringResource("Backlight", bundle: .app)
            static let blur = LocalizedStringResource("Blur", bundle: .app)
        }

        enum ColorExtendable {
            static let white = LocalizedStringResource("White", bundle: .app)
            static let red = LocalizedStringResource("Red", bundle: .app)
            static let pink = LocalizedStringResource("Pink", bundle: .app)
            static let orange = LocalizedStringResource("Orange", bundle: .app)
            static let yellow = LocalizedStringResource("Yellow", bundle: .app)
            static let green = LocalizedStringResource("Green", bundle: .app)
            static let mint = LocalizedStringResource("Mint", bundle: .app)
            static let cyan = LocalizedStringResource("Cyan", bundle: .app)
            static let blue = LocalizedStringResource("Blue", bundle: .app)
            static let indigo = LocalizedStringResource("Indigo", bundle: .app)
            static let purple = LocalizedStringResource("Purple", bundle: .app)
            static let black = LocalizedStringResource("Black", bundle: .app)
        }

        enum NumeralSystem {
            static let automatic = LocalizedStringResource("Automatic", bundle: .app)
            static let latin = LocalizedStringResource("Latin", bundle: .app)
            static let arabic = LocalizedStringResource("Arabic", bundle: .app)
            static let persian = LocalizedStringResource("Persian", bundle: .app)
            static let devanagari = LocalizedStringResource("Devanagari", bundle: .app)
        }

        enum AppLanguage {
            static let automatic = LocalizedStringResource("Language.automatic", defaultValue: "Automatic", bundle: .app)
            static let english = LocalizedStringResource("Language.english", defaultValue: "English", bundle: .app)
            static let spanish = LocalizedStringResource("Language.spanish", defaultValue: "Spanish", bundle: .app)
            static let german = LocalizedStringResource("Language.german", defaultValue: "German", bundle: .app)
            static let french = LocalizedStringResource("Language.french", defaultValue: "French", bundle: .app)
            static let russian = LocalizedStringResource("Language.russian", defaultValue: "Russian", bundle: .app)
            static let hebrew = LocalizedStringResource("Language.hebrew", defaultValue: "Hebrew", bundle: .app)
            static let arabic = LocalizedStringResource("Language.arabic", defaultValue: "Arabic", bundle: .app)
            static let farsi = LocalizedStringResource("Language.farsi", defaultValue: "Farsi", bundle: .app)
            static let hindi = LocalizedStringResource("Language.hindi", defaultValue: "Hindi", bundle: .app)
            static let sanskrit = LocalizedStringResource("Language.sanskrit", defaultValue: "Sanskrit", bundle: .app)
        }
    }

    enum Appearance {
        static let title = LocalizedStringResource("Appearance", bundle: .app)
        static let hideLabels = LocalizedStringResource("Hide labels", bundle: .app)
        static let hideLabelsHint = LocalizedStringResource("Show only digits, without any labels underneath.", bundle: .app)
        static let previewHint = LocalizedStringResource(
            "Close this window and click Preview to see all the changes in detail, full-screen.",
            bundle: .app
        )
    }

    enum Date {
        static let title = LocalizedStringResource("Date", bundle: .app)
        static let day = LocalizedStringResource("Day", bundle: .app)
        static let dayHint1 = LocalizedStringResource(
            "It can be any future date for Timer Mode or any past date for Stopwatch Mode.",
            bundle: .app
        )
        static let dayHint2 = LocalizedStringResource(
            "The available range is one year before and after the current date.",
            bundle: .app
        )
        static let dayHint3 = LocalizedStringResource(
            "When the countdown reaches zero, it automatically switches to Stopwatch Mode and starts counting up.",
            bundle: .app
        )
        static let time = LocalizedStringResource("Time", bundle: .app)
        static let timeHint = LocalizedStringResource("Defaults to midnight.", bundle: .app)
    }

    enum Theme {
        static let title = LocalizedStringResource("Theme", bundle: .app)
        static let color = LocalizedStringResource("Color", bundle: .app)
        static let brightness = LocalizedStringResource("Brightness", bundle: .app)
        static let effect = LocalizedStringResource("Effect", bundle: .app)
        static let effectHint = LocalizedStringResource("Adds an effect to the digits:", bundle: .app)
        static let effectColor = LocalizedStringResource("Effect Color", bundle: .app)
        static let glowWeightWarning = LocalizedStringResource("⚠️ Looks better at lighter weights.", bundle: .app)
        static let innerGlowWeightWarning = LocalizedStringResource(
            "⚠️ Looks better at Regular weight or higher.",
            bundle: .app
        )
        static let blurRoundedWarning = LocalizedStringResource("⚠️ Looks better with Rounded enabled.", bundle: .app)
    }

    enum Digits {
        static let title = LocalizedStringResource("Digits", bundle: .app)
        static let weight = LocalizedStringResource("Weight", bundle: .app)
        static let weightHint = LocalizedStringResource(
            "Sets the digit thickness from Ultra Light to Black.",
            bundle: .app
        )
        static let rounded = LocalizedStringResource("Round digits", bundle: .app)
        static let roundedHint = LocalizedStringResource("Renders the digits with the Rounded design.", bundle: .app)
        static let numerals = LocalizedStringResource("Numerals", bundle: .app)
        static let numeralsHint = LocalizedStringResource(
            "Sets the numeral system used for the digits. Automatic follows your Mac's region.",
            bundle: .app
        )
    }

    enum Title {
        static let title = LocalizedStringResource("Title", bundle: .app)
        static let titlePrompt = LocalizedStringResource(
            "Think of a cool idea for a screen saver title and write it here",
            bundle: .app
        )
        static let hideTitle = LocalizedStringResource("Hide title", bundle: .app)
        static let hideTitleHint = LocalizedStringResource("Hides the title even when it isn't empty.", bundle: .app)
    }

    enum Errors {
        static let saving = LocalizedStringResource(
            "Could not save settings. Try closing and reopening Settings, restarting your Mac, or reinstalling the screen saver.",
            bundle: .app
        )
    }

    enum Buttons {
        static let close = LocalizedStringResource("Close", bundle: .app)
    }
}
