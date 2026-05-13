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
    private let saver: SettingsSaver
    private let loader: SettingsLoader
    private let logger: Logger

    init(saver: SettingsSaver, loader: SettingsLoader? = nil) {
        self.saver = saver
        self.loader = loader ?? saver
        self.settings = .default
        self.logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        logger.log(
            "SettingsManager initialized with loader: \(String(describing: type(of: self.loader)), privacy: .public)"
        )
    }

    func load() {
        settings = loader.load()?.normalized ?? .default
        logger.log("Loaded settings, schedule.target: \(self.settings.schedule.target, privacy: .public)")
    }

    func save(_ settings: SaverSettings) throws {
        guard settings != self.settings else {
            logger.log("No changes, skipping save")
            return
        }
        do {
            try saver.save(settings)
            self.settings = settings
            logger.log("Saved settings, schedule.target: \(settings.schedule.target, privacy: .public)")
        } catch {
            let detail = (error as? LocalStoreError)?.logDescription ?? error.localizedDescription
            logger.error("Save failed: \(detail, privacy: .public)")
            throw error
        }
    }
}
