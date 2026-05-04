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
            appearance: .init(
                style: AppearanceStyle(defaults.showElementsIndex),
                isLabelHidden: false
            ),
            schedule: .init(target: defaults.targetDate),
            theme: .init(
                accent: AccentColor(defaults.colorIndex),
                background: BackgroundColor(defaults.backgroundColorIndex),
                brightness: defaults.brightIsNormal ? .normal : .dim,
                effect: .none,
                effectColor: .white
            ),
            typography: .init(weight: .ultraLight, isRounded: false),
            title: .init(text: defaults.messageString, isHidden: defaults.messageIsHidden)
        )
        logger.log("Loaded settings from defaults, schedule.target: \(settings.schedule.target, privacy: .public)")
        return settings
    }

    func save(_ settings: SaverSettings) throws {
        defaults.messageIsHidden = settings.title.isHidden
        defaults.brightIsNormal = settings.theme.brightness == .normal
        defaults.colorIndex = settings.theme.accent.rawValue
        defaults.backgroundColorIndex = settings.theme.background.rawValue
        defaults.showElementsIndex = settings.appearance.style.rawValue
        defaults.messageString = settings.title.text
        defaults.targetDate = settings.schedule.target
        guard defaults.synchronize() else {
            let caughtError = LocalStoreError.defaultsSyncFailed
            logger.error("\(caughtError.logDescription, privacy: .public)")
            throw caughtError
        }
        logger.log("Saved settings to defaults, schedule.target: \(settings.schedule.target, privacy: .public)")
    }
}
