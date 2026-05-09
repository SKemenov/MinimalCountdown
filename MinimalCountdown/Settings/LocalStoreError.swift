//
//  LocalStoreError.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum LocalStoreError: Error, LocalizedError {
    case directoryUnavailable(url: URL, underlying: Error)
    case encodingFailed(underlying: Error)
    case writeFailed(url: URL, underlying: Error)

    var logDescription: String {
        switch self {
            case .directoryUnavailable(let url, let underlying):
                "Could not create settings directory at \(url.path): \(underlying.localizedDescription)"
            case .encodingFailed(let underlying):
                "Could not encode settings: \(underlying.localizedDescription)"
            case .writeFailed(let url, let underlying):
                "Could not write settings to \(url.path): \(underlying.localizedDescription)"
        }
    }

    var errorDescription: String? { Resources.savingError }
}
