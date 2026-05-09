//
//  SaverSettings.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct SaverSettings: Codable, Equatable, Hashable {
    static let currentVersion = 2

    var version: Int = Self.currentVersion
    var appearance: Appearance
    var schedule: Schedule
    var theme: Theme
    var typography: Typography
    var title: Title
}

extension SaverSettings {
    var normalized: SaverSettings {
        var copy = self
        copy.schedule.target = max(Date.now.minDate, min(copy.schedule.target, Date.now.maxDate))
        return copy
    }
}

extension SaverSettings {
    static let `default` = SaverSettings(
        appearance: .init(style: .seconds, isLabelHidden: false),
        schedule: .init(target: Date(timeIntervalSinceNow: .oneDay * 30)),
        theme: .init(
            accent: .white,
            background: .black,
            brightness: .normal,
            effect: .none,
            effectColor: .white
        ),
        typography: .init(weight: .ultraLight, isRounded: false),
        title: .init(text: "", isHidden: true)
    )
}

#if DEBUG
extension SaverSettings {
    static let preview = SaverSettings(
        appearance: .init(style: .days, isLabelHidden: false),
        schedule: .init(target: Date(timeIntervalSinceNow: .oneDay * 365)),
        theme: .init(
            accent: .white,
            background: .black,
            brightness: .normal,
            effect: .none,
            effectColor: .white
        ),
        typography: .init(weight: .ultraLight, isRounded: false),
        title: .init(text: "See you soon", isHidden: false)
    )
}
#endif
