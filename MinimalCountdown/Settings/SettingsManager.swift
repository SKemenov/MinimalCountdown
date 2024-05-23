//
//  SettingsManager.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

final class SettingsManager {
    private(set) var settings: Settings
    private let stores: [LocalStore]

    init(stores: [LocalStore]) {
        self.stores = stores
        settings = .default
    }

    func load() {
        for store in stores {
            if var loaded = store.load() {
                let minDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * -1)
                let maxDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
                loaded.targetDate = max(minDate, min(loaded.targetDate, maxDate))
                settings = loaded
                return
            }
        }
        settings = .default
    }

    func save(_ settings: Settings) {
        self.settings = settings
        stores.forEach { $0.save(settings) }
    }
}
