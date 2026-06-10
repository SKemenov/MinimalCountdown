//
//  SettingsPersistenceTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
@MainActor
struct `Settings Persistence Tests` {

    private func changed(_ text: String) -> SaverSettings {
        var settings = SaverSettings.default
        settings.title = Title(text: text, isHidden: false)
        return settings
    }

    @Test func `load Applies Normalized From Store`() {
        let sui = SettingsManager(saver: MockInMemoryLocalStore(initial: .default))
        sui.load()
        #expect(sui.settings == SaverSettings.default)
    }

    @Test func `save Changed Persists And Updates`() throws {
        let store = MockInMemoryLocalStore(initial: .default)
        let sui = SettingsManager(saver: store)
        sui.load()
        let new = changed("Launch day")
        try sui.save(new)
        #expect(sui.settings == new)
        #expect(store.load() == new)
    }

    @Test func `skips Save When Unchanged`() {
        // A shouldFail store throws IF reached; an unchanged save must short-circuit before it.
        let sui = SettingsManager(saver: MockInMemoryLocalStore(initial: .default, shouldFail: true))
        sui.load()  // settings == .default
        #expect(throws: Never.self) { try sui.save(.default) }
    }

    @Test func `propagates Save Failure When Changed`() {
        let sui = SettingsManager(saver: MockInMemoryLocalStore(initial: .default, shouldFail: true))
        sui.load()
        #expect(throws: MockSaveError.self) { try sui.save(changed("x")) }
    }

    @Test func `migrating Loader Promotes Fallback To Saver`() {
        let saver = MockInMemoryLocalStore(initial: nil)
        let promoted = changed("promoted")
        let fallback = MockInMemoryLocalStore(initial: promoted)
        let sui = MigratingLoader(saver: saver, fallback: fallback)

        let result = sui.load()
        #expect(result == promoted)
        #expect(saver.load() == promoted)  // written back to the saver
    }

    @Test func `normalized Clamps Out Of Range Target`() {
        var sui = SaverSettings.default
        #expect(sui.normalized.schedule.target == sui.schedule.target)  // in-range: unchanged

        sui.schedule.target = .distantFuture
        #expect(sui.normalized.schedule.target < sui.schedule.target)   // clamped down to maxDate

        sui.schedule.target = .distantPast
        #expect(sui.normalized.schedule.target > sui.schedule.target)   // clamped up to minDate
    }
}
