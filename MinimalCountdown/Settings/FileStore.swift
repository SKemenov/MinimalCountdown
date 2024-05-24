//
//  FileStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

final class FileStore: LocalStore {
    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    static let defaultURL: URL = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent(Resources.settingsFolderName, isDirectory: true)
        .appendingPathComponent(Resources.settingsFileName)

    init(fileURL: URL = FileStore.defaultURL) {
        self.fileURL = fileURL
        encoder = JSONEncoder.saverEncoder()
        decoder = JSONDecoder.saverDecoder()
    }

    func load() -> Settings? {
        do {
            let data = try Data(contentsOf: fileURL)
            let settings = try decoder.decode(Settings.self, from: data)
            return settings
        } catch {
            return nil
        }
    }

    func save(_ settings: Settings) {
        let directory = fileURL.deletingLastPathComponent()
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } catch {
            return
        }
        do {
            let data = try encoder.encode(settings)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            return
        }
    }
}
