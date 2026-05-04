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
            if let loaded = store.load() {
                settings = loaded.normalized
                let message = "Loaded from \(String(describing: type(of: store))), schedule.target: \(settings.schedule.target)"
                logger.log("\(message, privacy: .public)")
                return
            }
        }
        settings = .default
        logger.log("Store(s) had no settings, using .default value")
    }

    func save(_ settings: SaverSettings) throws {
        guard settings != self.settings else {
            logger.log("No changes in settings, skipping save")
            return
        }

        var successes = 0
        var failures: [(storeLabel: String, error: Error)] = []
        for store in stores {
            let label = String(describing: type(of: store))
            do {
                try store.save(settings)
                successes += 1
                logger.log("Saved to \(label, privacy: .public)")
            } catch {
                failures.append((label, error))
                logger.error("Failed to save to \(label, privacy: .public): \(error, privacy: .public)")
            }
        }

        if successes > 0 {
            self.settings = settings
        }

        if failures.count == stores.count {
            throw SaveAllStoresFailedError(failures: failures)
        }

        let message = "Saved (successes: \(successes), failures: \(failures.count)), schedule.target: \(settings.schedule.target)"
        logger.log("\(message, privacy: .public)")
    }
}

struct SaveAllStoresFailedError: Error, LocalizedError {
    let failures: [(storeLabel: String, error: Error)]
    var errorDescription: String? { Resources.savingError }
}
