//
//  DefaultsStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import ScreenSaver

final class DefaultsStore: LocalStore {
    private let defaults: ScreenSaverDefaults

    init?(bundleIdentifier: String) {
        guard let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            return nil
        }
        self.defaults = defaults
    }

    func load() -> Settings? {
        guard defaults.targetDate.timeIntervalSince1970 != 0.0 else {
            return nil
        }
        let settings = Settings(
            targetDate: defaults.targetDate,
            color: AccentColor(defaults.colorIndex),
            backgroundColor: BackgroundColor(defaults.backgroundColorIndex),
            style: StyleElement(defaults.showElementsIndex),
            message: defaults.messageString,
            isMessageHidden: defaults.messageIsHidden,
            isBrightNormal: defaults.brightIsNormal
        )
        return settings
    }

    func save(_ settings: Settings) {
        defaults.messageIsHidden = settings.isMessageHidden
        defaults.brightIsNormal = settings.isBrightNormal
        defaults.colorIndex = settings.color.rawValue
        defaults.backgroundColorIndex = settings.backgroundColor.rawValue
        defaults.showElementsIndex = settings.style.rawValue
        defaults.messageString = settings.message
        defaults.targetDate = settings.targetDate
        defaults.synchronize()
    }
}
