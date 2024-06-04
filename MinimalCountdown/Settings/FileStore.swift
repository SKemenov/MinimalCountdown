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

    static let defaultURL: URL = shouldBeNonSandboxButRealHomeDirectory
        .appendingPathComponent(Resources.settingsFolderName, isDirectory: true)
        .appendingPathComponent(Resources.settingsFileName)

    init(fileURL: URL = FileStore.defaultURL) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        self.fileURL = fileURL
        encoder = JSONEncoder.saverEncoder()
        decoder = JSONDecoder.saverDecoder()
        logger.log("Initialized with fileURL: \(fileURL.path, privacy: .public)")
    }

    func load() -> Settings? {
        do {
            let data = try Data(contentsOf: fileURL)
            let settings = try decoder.decode(Settings.self, from: data)
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

    func save(_ settings: Settings) {
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
    /// Returns the real home directory, bypassing sandbox path redirection.
    /// Screen savers run inside com.apple.ScreenSaver.Engine.legacyScreenSaver container,
    /// so FileManager.homeDirectoryForCurrentUser returns the sandboxed path.
    /// getpwuid reads from the system passwd database and is not affected by sandbox redirection.
    static let shouldBeNonSandboxButRealHomeDirectory: URL = {
        if let pwdb = getpwuid(getuid()), let homeDirectory = pwdb.pointee.pw_dir {
            return URL(fileURLWithPath: String(cString: homeDirectory))
        } else {
            // fallback to the com.apple.ScreenSaver.Engine.legacyScreenSaver sandboxed path
            return FileManager.default.homeDirectoryForCurrentUser
        }
    }()
}
