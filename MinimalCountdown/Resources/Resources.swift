//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Localization properties
enum Resources {
    /// Single source of truth for strings that used to be derived inline via `String(describing:)`.
    /// Mirrors the model enums; `Phase 10` converts these to `LocalizedStringResource`.
    enum Labels {
        enum AppearanceStyle {
            static let days = "Days"
            static let hours = "Hours"
            static let minutes = "Minutes"
            static let seconds = "Seconds"
        }

        enum Brightness {
            static let low = "Low"
            static let medium = "Medium"
            static let high = "High"
        }

        enum FontWeight {
            static let ultraLight = "Ultra Light"
            static let thin = "Thin"
            static let light = "Light"
            static let regular = "Regular"
            static let medium = "Medium"
            static let semibold = "Semibold"
            static let bold = "Bold"
            static let heavy = "Heavy"
            static let black = "Black"
        }

        enum EffectStyle {
            static let none = "None"
            static let glow = "Glow"
            static let innerGlow = "Inner Glow"
            static let backlight = "Backlight"
            static let blur = "Blur"
        }

        enum AccentColor {
            static let white = "White"
            static let red = "Red"
            static let pink = "Pink"
            static let orange = "Orange"
            static let yellow = "Yellow"
            static let green = "Green"
            static let mint = "Mint"
            static let cyan = "Cyan"
            static let blue = "Blue"
            static let indigo = "Indigo"
            static let purple = "Purple"
        }
    }

    enum Appearance {
        static let title = "Appearance"
        static let hideLabels = "Hide labels"
        static let hideLabelsHint = "Show only digits, no DAYS / HOURS / etc."
        static let previewHint = "Close this window and click Preview to see all the changes in detail in full screen mode."
    }

    enum Date {
        static let title = "Date"
        static let day = "Day"
        static let dayHint1 = "It can be any future date for Timer Mode or any past date for Stopwatch Mode."
        static let dayHint2 = "The available range is two years from the current date."
        static let dayHint3 = "When the countdown reaches zero, it automatically switches to Stopwatch Mode and starts counting up."
        static let time = "Time"
        static let timeHint = "By default it will be set to midnight"
    }

    enum Theme {
        static let title = "Theme"
        static let color = "Color"
        static let brightness = "Brightness"
        static let effect = "Effect"
        static let effectHint = "Adds a glow, inner glow, backlight, or blur to the digits."
        static let effectColor = "Effect Color"
        static let glowWeightWarning = "⚠️ Looks better at lighter weights."
        static let innerGlowWeightWarning = "⚠️ Looks better at Regular weight or higher."
        static let blurRoundedWarning = "⚠️ Looks better with Rounded enabled."
    }

    enum Font {
        static let title = "Font"
        static let weight = "Weight"
        static let weightHint = "Sets the digit thickness from Ultra Light to Black."
        static let rounded = "Rounded"
        static let roundedHint = "Renders the digits with the SF Rounded design."
    }

    enum Title {
        static let title = "Title"
        static let messagePrompt = "Add your message here"
        static let hideTitle = "Hide title"
        static let hideTitleHint = "Even title is not empty"
    }

    enum Errors {
        static let saving = "Could not save settings. Try restarting, reinstalling the saver, or filing an issue."
    }

    enum Buttons {
        static let close = "Close"
    }
}
