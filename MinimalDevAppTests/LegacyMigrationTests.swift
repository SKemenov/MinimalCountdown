//
//  LegacyMigrationTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
@MainActor
struct `Legacy Migration Tests` {

    private let testDate = Date(timeIntervalSince1970: 1_700_000_000)
    private let testTitle = "Launch"

    private func makeV1(isBrightNormal: Bool) -> LegacySettings.V1 {
        LegacySettings.V1(
            targetDate: testDate,
            color: .red,
            backgroundColor: .white,
            style: .hours,
            message: testTitle,
            isMessageHidden: false,
            isBrightNormal: isBrightNormal
        )
    }

    @Test func `brightness Mapping`() {
        #expect(makeV1(isBrightNormal: true).upgraded.theme.brightness == .high)
        #expect(makeV1(isBrightNormal: false).upgraded.theme.brightness == .medium)
    }

    @Test func `carries Fields Through`() {
        let sui = makeV1(isBrightNormal: true).upgraded
        #expect(sui.appearance.style == .hours)
        #expect(sui.theme.accent == .red)
        #expect(sui.theme.background == .white)
        #expect(sui.title.text == testTitle)
        #expect(sui.title.isHidden == false)
        #expect(sui.schedule.target == testDate)
    }

    @Test func `applies V2 Defaults`() {
        let sui = makeV1(isBrightNormal: true).upgraded
        #expect(sui.version == SaverSettings.currentVersion)
        #expect(sui.appearance.isLabelHidden == false)
        #expect(sui.theme.effect == .none)
        #expect(sui.theme.effectColor == .white)
        #expect(sui.typography.weight == .ultraLight)
        #expect(sui.typography.isRounded == false)
        #expect(sui.typography.numeralSystem == .automatic)
        // NOTE: commit 2 (E2 — LanguageCode collapse) updates this assertion.
        #expect(sui.language.countdownLanguage == .automatic)
    }
}
