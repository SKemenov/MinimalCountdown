//
//  Settings.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct SaverSettings: Codable, Equatable, Hashable {
    var targetDate: Date
    var color: AccentColor
    var backgroundColor: BackgroundColor
    var style: AppearanceStyle
    var message: String
    var isMessageHidden: Bool
    var isBrightNormal: Bool
    var isExtra: Bool?

    var digitsColor: Color {
        self.color.color.opacity(self.isBrightNormal ? .normalBright.digits : .dimBright.digits)
    }

    var textsColor: Color {
        self.color.color.opacity(self.isBrightNormal ? .normalBright.texts : .dimBright.texts)
    }
}

extension SaverSettings {
    static let `default` = SaverSettings(
        targetDate: Date(timeIntervalSinceNow: .oneDay * 30),
        color: .white,
        backgroundColor: .black,
        style: .seconds,
        message: "",
        isMessageHidden: false,
        isBrightNormal: true
    )
}

#if DEBUG
extension SaverSettings {
    static let preview = SaverSettings(
        targetDate: Date(timeIntervalSinceNow: .oneDay * 365),
        color: .white,
        backgroundColor: .black,
        style: .days,
        message: "See you soon",
        isMessageHidden: false,
        isBrightNormal: true
    )
}
#endif
