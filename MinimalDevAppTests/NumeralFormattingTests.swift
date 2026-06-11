//
//  NumeralFormattingTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
struct `Numeral Formatting Tests` {

    private func locale(_ system: NumeralSystem) -> Locale {
        var components = Locale.Components(identifier: "en_US")
        if let numbering = system.numberingSystem { components.numberingSystem = numbering }
        return Locale(components: components)
    }

    @Test func `numbering System Identifiers`() {
        #expect(NumeralSystem.automatic.numberingSystem == nil)
        #expect(NumeralSystem.latin.numberingSystem == Locale.NumberingSystem("latn"))
        #expect(NumeralSystem.arabic.numberingSystem == Locale.NumberingSystem("arab"))
        #expect(NumeralSystem.persian.numberingSystem == Locale.NumberingSystem("arabext"))
        #expect(NumeralSystem.devanagari.numberingSystem == Locale.NumberingSystem("deva"))
    }

    @Test func `zero Pads To Minimum Two Digits`() {
        let latin = locale(.latin)
        #expect(UIModel.formattedDigits(0, in: latin) == "00")
        #expect(UIModel.formattedDigits(5, in: latin) == "05")
        #expect(UIModel.formattedDigits(42, in: latin) == "42")
    }

    @Test func `grows Beyond Two Without Grouping`() {
        let latin = locale(.latin)
        #expect(UIModel.formattedDigits(123, in: latin) == "123")
        #expect(UIModel.formattedDigits(1234, in: latin) == "1234")  // no thousands separator
    }

    @Test func `renders Per Numeral System`() {
        #expect(UIModel.formattedDigits(5, in: locale(.latin)) == "05")
        #expect(UIModel.formattedDigits(5, in: locale(.arabic)) == "٠٥")
        #expect(UIModel.formattedDigits(5, in: locale(.persian)) == "۰۵")
        #expect(UIModel.formattedDigits(5, in: locale(.devanagari)) == "०५")
    }
}
