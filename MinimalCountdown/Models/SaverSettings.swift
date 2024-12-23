//
//  Settings.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct SaverSettings: Codable, Equatable, Hashable {
    var targetDate: Date
    var color: AccentColor
    var backgroundColor: BackgroundColor
    var style: StyleElement
    var message: String
    var isMessageHidden: Bool
    var isBrightNormal: Bool
    var isExtra: Bool?
}

extension SaverSettings {
    static let `default` = SaverSettings(
        targetDate: Date(timeIntervalSinceNow: 60 * 60 * 24 * 30),
        color: .white,
        backgroundColor: .black,
        style: .seconds,
        message: "",
        isMessageHidden: false,
        isBrightNormal: true
    )
}
