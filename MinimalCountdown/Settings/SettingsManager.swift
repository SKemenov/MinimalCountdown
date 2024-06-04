//
//  SettingsManager.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation
import OSLog

final class SettingsManager {
    private(set) var settings: Settings
    private let stores: [LocalStore]
    private let logger: Logger

    init(stores: [LocalStore]) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        self.stores = stores
        settings = .default
        logger.log("Initialized with \(stores.count, privacy: .public) store(s)")
    }

    func load() {
        for store in stores {
            if var loaded = store.load() {
                let minDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * -1)
                let maxDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
                loaded.targetDate = max(minDate, min(loaded.targetDate, maxDate))
                settings = loaded
                let message = "Loaded from \(String(describing: type(of: store))), targetDate: \(loaded.targetDate)"
                logger.log("\(message, privacy: .public)")
                return
            }
        }
        settings = .default
        logger.log("No store had settings, using defaults")
    }

    func save(_ settings: Settings) {
        self.settings = settings
        stores.forEach { $0.save(settings) }
        let message = "Settings saved to \(stores.count) store(s), targetDate: \(settings.targetDate)"
        logger.log("\(message, privacy: .public)")
    }
}
