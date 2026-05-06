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
        do {
            let data = try Data(contentsOf: fileURL)
            let settings = try decoder.decode(SaverSettings.self, from: data)
            logger.log("Loaded settings from file: \(self.fileURL.path, privacy: .public)")
            return settings
        } catch CocoaError.fileNoSuchFile, CocoaError.fileReadNoSuchFile {
            logger.log("No settings file found at: \(self.fileURL.path, privacy: .public)")
            return nil
        } catch {
            logger.error("Failed to load settings from file: \(error, privacy: .public)")
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

extension FileLocalStore {
    // Both saver and DevApp resolve to /Users/Shared/MinimalCountdown/settings.json.
    static var defaultDirectory: URL {
        URL.userDirectory.appending(component: "Shared", directoryHint: .isDirectory)
    }
}
