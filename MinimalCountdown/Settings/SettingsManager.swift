//
//  SettingsManager.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation
import Observation
import OSLog

@Observable
final class SettingsManager {
    private(set) var settings: SaverSettings
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
                loaded.targetDate = max(Date.now.minDate, min(loaded.targetDate, Date.now.maxDate))
                settings = loaded
                let message = "Loaded from \(String(describing: type(of: store))), targetDate: \(loaded.targetDate)"
                logger.log("\(message, privacy: .public)")
                return
            }
        }
        settings = .default
        logger.log("Store(s) had no settings, using .default value")
    }

    func save(_ settings: SaverSettings) {
        guard settings != self.settings else {
            logger.log("No changes in settings, skipping save")
            return
        }
        self.settings = settings
        stores.forEach { try? $0.save(settings) }
        let message = "Settings saved to \(stores.count) store(s), targetDate: \(settings.targetDate)"
        logger.log("\(message, privacy: .public)")
    }
}
