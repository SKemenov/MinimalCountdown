//
//  DefaultsLocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import OSLog
import ScreenSaver

final class DefaultsLocalStore: SettingsLoader {
    private let defaults: ScreenSaverDefaults
    private let logger: Logger

    init?(bundleIdentifier: String = AppSettings.subSystem) {
        logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        guard let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            logger.error("Failed to create ScreenSaverDefaults for bundle: \(bundleIdentifier, privacy: .public)")
            return nil
        }
        self.defaults = defaults
        logger.log("Initialized with bundle: \(bundleIdentifier, privacy: .public)")
    }

    func load() -> SaverSettings? {
        guard defaults.targetDate.timeIntervalSince1970 != 0.0 else {
            logger.log("No saved settings in defaults (targetDate is zero)")
            return nil
        }
        let v1 = LegacySettings.V1(
            targetDate:      defaults.targetDate,
            color:           AccentColor(defaults.colorIndex),
            backgroundColor: BackgroundColor(defaults.backgroundColorIndex),
            style:           AppearanceStyle(defaults.showElementsIndex),
            message:         defaults.messageString,
            isMessageHidden: defaults.messageIsHidden,
            isBrightNormal:  defaults.brightIsNormal
        )
        let settings = LegacySettings.v1(v1).upgradedToCurrent
        logger.log("Loaded settings from defaults, schedule.target: \(settings.schedule.target, privacy: .public)")
        return settings
    }
}
