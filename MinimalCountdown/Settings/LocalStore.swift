//
//  LocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol LocalStore {
    func load() -> SaverSettings?
    func save(_ settings: SaverSettings) throws
}

enum LocalStoreError: Error, LocalizedError {
    case directoryUnavailable(url: URL, underlying: Error)
    case encodingFailed(underlying: Error)
    case writeFailed(url: URL, underlying: Error)
    case defaultsSyncFailed

    var logDescription: String {
        switch self {
            case .directoryUnavailable(let url, let underlying):
                "Could not create settings directory at \(url.path): \(underlying.localizedDescription)"
            case .encodingFailed(let underlying):
                "Could not encode settings: \(underlying.localizedDescription)"
            case .writeFailed(let url, let underlying):
                "Could not write settings to \(url.path): \(underlying.localizedDescription)"
            case .defaultsSyncFailed:
                "ScreenSaverDefaults.synchronize() returned false"
        }
    }

    var errorDescription: String? { logDescription }
}
