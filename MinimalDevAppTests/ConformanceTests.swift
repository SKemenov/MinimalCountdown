//
//  ConformanceTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

// Custom conformances only — synthesized Equatable/Hashable on plain enums aren't tested
// (that would test the compiler). These drive real behavior: Comparable powers the
// AppearancePicker hover + font guard-rails; ColorExtendable's id-based `==` is paired
// with a synthesized hash, so their consistency is worth pinning.

@Suite
@MainActor
struct `Conformance Tests` {

    @Test func `appearance Style Is Ordered`() {
        // Custom `<` drives AppearancePicker hover (`style <= markedStyle`).
        #expect(AppearanceStyle.allCases == AppearanceStyle.allCases.sorted())
        #expect(AppearanceStyle.days < .seconds)
        #expect(AppearanceStyle.seconds <= .seconds)
        #expect(!(AppearanceStyle.seconds < .days))
    }

    @Test func `font Weight Is Ordered`() {
        #expect(FontWeight.allCases == FontWeight.allCases.sorted())
        #expect(FontWeight.ultraLight < .black)
    }

    @Test func `font Weight Guard Rail Thresholds`() {
        // DigitsSectionView warns: glow at weight >= .bold; innerGlow at weight < .regular.
        #expect(FontWeight.semibold < .bold)       // below the glow threshold
        #expect(!(FontWeight.bold < .bold))         // bold reaches it
        #expect(FontWeight.thin < .regular)         // below the innerGlow threshold
        #expect(!(FontWeight.regular < .regular))   // regular does not
    }

    @Test func `color Equality And Hashing`() {
        // Custom id-based `==` + synthesized hash must agree (no Set collisions merging cases).
        #expect(AccentColor.red == .red)
        #expect(AccentColor.red != .blue)
        #expect(Set(AccentColor.allCases).count == AccentColor.allCases.count)
        #expect(Set(BackgroundColor.allCases).count == BackgroundColor.allCases.count)
    }

    @Test func `app Language Code Is Nil Only For Automatic`() {
        // `.automatic` returns nil (the locale-override step is skipped); every other case
        // carries a non-nil ISO code, and they're all distinct.
        #expect(AppLanguage.automatic.languageCode == nil)
        let sut = AppLanguage.allCases.compactMap(\.languageCode)
        #expect(sut.count == AppLanguage.allCases.count - 1)
        #expect(Set(sut).count == sut.count)
    }
}
