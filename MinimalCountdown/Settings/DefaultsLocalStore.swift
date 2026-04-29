//
//  DefaultsLocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import OSLog
import ScreenSaver

final class DefaultsLocalStore: LocalStore {
    private let defaults: ScreenSaverDefaults
    private let logger: Logger

    init?(bundleIdentifier: String = Resources.subSystem) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
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
        let settings = SaverSettings(
            targetDate: defaults.targetDate,
            color: AccentColor(defaults.colorIndex),
            backgroundColor: BackgroundColor(defaults.backgroundColorIndex),
            style: AppearanceStyle(defaults.showElementsIndex),
            message: defaults.messageString,
            isMessageHidden: defaults.messageIsHidden,
            isBrightNormal: defaults.brightIsNormal
        )
        logger.log("Loaded settings from defaults, targetDate: \(settings.targetDate, privacy: .public)")
        return settings
    }

    func save(_ settings: SaverSettings) throws {
        defaults.messageIsHidden = settings.isMessageHidden
        defaults.brightIsNormal = settings.isBrightNormal
        defaults.colorIndex = settings.color.rawValue
        defaults.backgroundColorIndex = settings.backgroundColor.rawValue
        defaults.showElementsIndex = settings.style.rawValue
        defaults.messageString = settings.message
        defaults.targetDate = settings.targetDate
        guard defaults.synchronize() else {
            let caughtError = LocalStoreError.defaultsSyncFailed
            logger.error("\(caughtError.logDescription, privacy: .public)")
            throw caughtError
        }
        logger.log("Saved settings to defaults, targetDate: \(settings.targetDate, privacy: .public)")
    }
}
