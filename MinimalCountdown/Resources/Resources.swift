//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum Resources {
    // MARK: - Dictionaries
    static let subSystem = "MinimalCountdown"

    static let settingsFileName = "settings.json"

    enum Labels {
        static let MessageTitle = "Message:"
        static let ColorTitle = "Color:"
        static let DateTitle = "Date:"
        static let StyleTitle = "Style:"

        static let messagePlaceholder = "Input your message here"
        static let messageCheckboxTitle = "Show the message"
        static let dimCheckboxTitle = "Dim the accent color"

        static let OkButtonTitle = "OK"
        static let CancelButtonTitle = "Cancel"
    }
}
