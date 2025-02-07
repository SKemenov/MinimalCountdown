//
//  FileStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation
import OSLog

final class FileStore: LocalStore {
    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let logger: Logger

    init(supportDirectory: URL = FileStore.defaultDirectory) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        encoder = JSONEncoder.saverEncoder()
        decoder = JSONDecoder.saverDecoder()
        fileURL = supportDirectory
            .appending(component: Resources.subSystem, directoryHint: .isDirectory)
            .appending(component: Resources.settingsFileName)
        logger.log("FileStore initialized with fileURL: \(self.fileURL.path, privacy: .public)")
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

    func save(_ settings: SaverSettings) {
        let directory = fileURL.deletingLastPathComponent()
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } catch {
            logger.error("Failed to create directory \(directory.path, privacy: .public): \(error)")
            return
        }
        do {
            let data = try encoder.encode(settings)
            try data.write(to: fileURL, options: .atomic)
            logger.log("Saved settings to file: \(self.fileURL.path, privacy: .public)")
        } catch {
            logger.error("Failed to save settings to file: \(error)")
            return
        }
    }
}

extension FileStore {
    // Both saver and DevApp resolve to /Users/Shared/MinimalCountdown/settings.json.
    static var defaultDirectory: URL {
        URL(fileURLWithPath: "/Users/Shared", isDirectory: true)
    }
}
