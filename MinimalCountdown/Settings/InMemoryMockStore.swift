//
//  InMemoryMockStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

#if DEBUG
import Foundation

final class InMemoryMockStore: LocalStore {
    private var storedSettings: SaverSettings?
    private let shouldFail: Bool

    init(initial: SaverSettings? = nil, shouldFail: Bool = false) {
        self.storedSettings = initial
        self.shouldFail = shouldFail
    }

    func load() -> SaverSettings? { storedSettings }

    func save(_ settings: SaverSettings) throws {
        if shouldFail { throw MockSaveError() }
        storedSettings = settings
    }
}

struct MockSaveError: Error, LocalizedError {
    var errorDescription: String? { "InMemoryMockStore simulated failure" }
}
#endif
