//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum Resources {
    static let subSystem = "MinimalCountdown"
    static let settingsFileName = "settings.json"
    static let savingError = "Could not save settings. Try restarting, reinstalling the saver, or filing an issue."

    enum Copy {
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
        }

        enum Title {
            static let title = "Title"
            static let messagePrompt = "Add your message here"
            static let hideTitle = "Hide title"
            static let hideTitleHint = "Even title is not empty"
        }

        enum Buttons {
            static let close = "Close"
        }
    }
}
