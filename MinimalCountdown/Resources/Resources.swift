//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Localization properties
enum Resources {
    enum Appearance {
        static let title = "Appearance"
        static let style = "Style"
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
        static let shadowWeightWarning = "⚠️ Looks better at lighter weights."
        static let innerShadowWeightWarning = "⚠️ Looks better at Regular weight or higher."
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
