//
//  Settings.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct Settings: Codable {
    var targetDate: Date
    var color: AccentColor
    var backgroundColor: BackgroundColor
    var style: StyleElement
    var message: String
    var isMessageHidden: Bool
    var isBrightNormal: Bool
}

extension Settings {
    static let `default` = Settings(
        targetDate: Date(timeIntervalSinceNow: 60 * 60 * 24 * 30),
        color: .white,
        backgroundColor: .black,
        style: .seconds,
        message: "Check Minimal Countdown",
        isMessageHidden: false,
        isBrightNormal: true
    )
}
