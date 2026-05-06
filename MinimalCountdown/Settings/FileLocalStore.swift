//
//  FileLocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation
import OSLog

final class FileLocalStore: SettingsSaver {
    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let logger: Logger

    init(supportDirectory: URL = FileLocalStore.defaultDirectory) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        encoder = JSONEncoder.saverEncoder()
        decoder = JSONDecoder.saverDecoder()
        fileURL = supportDirectory
            .appending(component: Resources.subSystem, directoryHint: .isDirectory)
            .appending(component: Resources.settingsFileName)
        logger.log("FileLocalStore initialized with fileURL: \(self.fileURL.path, privacy: .public)")
    }

    func load() -> SaverSettings? {
        let data: Data
        do {
            data = try Data(contentsOf: fileURL)
        } catch CocoaError.fileNoSuchFile, CocoaError.fileReadNoSuchFile {
            logger.log("No settings file found at: \(self.fileURL.path, privacy: .public)")
            return nil
        } catch {
            logger.error("Failed to read settings file: \(error, privacy: .public)")
            return nil
        }

        let probe = try? decoder.decode(VersionProbe.self, from: data)
        switch probe?.version {
            case SaverSettings.currentVersion:
                do {
                    let settings = try decoder.decode(SaverSettings.self, from: data)
                    logger.log("Loaded settings v\(SaverSettings.currentVersion, privacy: .public) from file")
                    return settings
                } catch {
                    logger.error("Failed to decode v\(SaverSettings.currentVersion, privacy: .public) settings: \(error, privacy: .public)")
                    return nil
                }
            case nil, 1:
                return migrateV1(from: data)
            case let other?:
                logger.error("Unknown settings version \(other, privacy: .public), refusing to load")
                return nil
        }
    }

    func save(_ settings: SaverSettings) throws {
        let directory = fileURL.deletingLastPathComponent()
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } catch {
            let caughtError = LocalStoreError.directoryUnavailable(url: directory, underlying: error)
            logger.error("\(caughtError.logDescription, privacy: .public)")
            throw caughtError
        }

        let data: Data
        do {
            data = try encoder.encode(settings)
        } catch {
            let caughtError = LocalStoreError.encodingFailed(underlying: error)
            logger.error("\(caughtError.logDescription, privacy: .public)")
            throw caughtError
        }

        do {
            try data.write(to: fileURL, options: .atomic)
            logger.log("Saved settings to file: \(self.fileURL.path, privacy: .public)")
        } catch {
            let caughtError = LocalStoreError.writeFailed(url: fileURL, underlying: error)
            logger.error("\(caughtError.logDescription, privacy: .public)")
            throw caughtError
        }
    }
}

private extension FileLocalStore {
    func migrateV1(from data: Data) -> SaverSettings? {
        do {
            let legacy = try LegacySettings.decode(version: 1, from: data, using: decoder)
            let migrated = legacy.upgradedToCurrent
            do {
                try save(migrated)
                logger.log("Migrated settings v1 → v\(SaverSettings.currentVersion, privacy: .public) and rewrote file")
            } catch {
                logger.error("v1 migration succeeded but rewrite failed: \(error, privacy: .public)")
            }
            return migrated
        } catch {
            logger.error("Failed to decode legacy v1 settings: \(error, privacy: .public)")
            return nil
        }
    }
}

private struct VersionProbe: Decodable {
    let version: Int?
}

extension FileLocalStore {
    // Both saver and DevApp resolve to /Users/Shared/MinimalCountdown/settings.json.
    static var defaultDirectory: URL {
        URL.userDirectory.appending(component: "Shared", directoryHint: .isDirectory)
    }
}
