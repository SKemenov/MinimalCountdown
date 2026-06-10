//
//  SafeIntDecodableTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

// MARK: - SafeIntDecodable (crash-safety contract)

@Suite
@MainActor
struct `Safe Int Decodable Tests` {

    @Test func `appearance Style Fallback`() {
        #expect(AppearanceStyle(99) == .seconds)
        #expect(AppearanceStyle(-1) == .seconds)
        #expect(AppearanceStyle(0) == .days)
        #expect(AppearanceStyle(3) == .seconds)
    }

    @Test func `brightness Fallback`() {
        #expect(Brightness(99) == .high)
        #expect(Brightness(-1) == .high)
        #expect(Brightness(0) == .low)
        #expect(Brightness(2) == .high)
    }

    @Test func `effect Style Fallback`() {
        #expect(EffectStyle(99) == .none)
        #expect(EffectStyle(-1) == .none)
        #expect(EffectStyle(0) == .none)
        #expect(EffectStyle(1) == .glow)
    }

    @Test func `font Weight Fallback`() {
        #expect(FontWeight(99) == .ultraLight)
        #expect(FontWeight(-1) == .ultraLight)
        #expect(FontWeight(0) == .ultraLight)
        #expect(FontWeight(8) == .black)
    }

    @Test func `numeral System Fallback`() {
        #expect(NumeralSystem(99) == .automatic)
        #expect(NumeralSystem(-1) == .automatic)
        #expect(NumeralSystem(0) == .automatic)
        #expect(NumeralSystem(2) == .arabic)
    }

    @Test func `accent Color Fallback`() {
        #expect(AccentColor(99) == .white)
        #expect(AccentColor(-1) == .white)
        #expect(AccentColor(0) == .white)
        #expect(AccentColor(1) == .red)
    }

    @Test func `background Color Fallback`() {
        #expect(BackgroundColor(99) == .black)
        #expect(BackgroundColor(-1) == .black)
        #expect(BackgroundColor(0) == .black)
        #expect(BackgroundColor(1) == .white)
    }

    @Test func `app Language Fallback`() {
        #expect(AppLanguage(99) == .automatic)
        #expect(AppLanguage(-1) == .automatic)
        #expect(AppLanguage(0) == .automatic)
        #expect(AppLanguage(1) == .english)
    }

    // One array decodes three raws at once: 0/2 map straight through, out-of-range 99 → .seconds.
    @Test func `decodes Out Of Range To Default`() throws {
        let sui = try JSONDecoder().decode([AppearanceStyle].self, from: Data("[0, 2, 99]".utf8))
        #expect(sui == [.days, .minutes, .seconds])
    }

    @Test func `encode Decode Round Trips`() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        for value in Brightness.allCases {
            let data = try encoder.encode(value)
            #expect(try decoder.decode(Brightness.self, from: data) == value)
        }
    }
}
