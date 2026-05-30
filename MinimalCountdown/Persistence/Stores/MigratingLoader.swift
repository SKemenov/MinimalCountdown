//
//  MigratingLoader.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation
import OSLog

struct MigratingLoader: SettingsLoader {
    let saver: SettingsSaver
    let fallback: SettingsLoader
    private let logger: Logger
    
    init(saver: SettingsSaver, fallback: SettingsLoader) {
        self.saver = saver
        self.fallback = fallback
        self.logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
    }
    
    func load() -> SaverSettings? {
        if let primary = saver.load() {
            return primary
        }
        guard let migrated = fallback.load() else {
            return nil
        }
        do {
            try saver.save(migrated)
            logger.log("Promoted settings from \(String(describing: type(of: fallback)), privacy: .public)")
        } catch {
            let detail = (error as? LocalStoreError)?.logDescription ?? error.localizedDescription
            logger.error("Promotion write failed: \(detail, privacy: .public)")
        }
        return migrated
    }
}
