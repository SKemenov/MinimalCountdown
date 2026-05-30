//
//  RenderSettingsTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
@MainActor
struct `Render Settings Tests` {

    private func render(language: AppLanguage, locale: Locale = Locale(identifier: "en_US")) -> UIModel.RenderSettings {
        var settings = SaverSettings.default
        settings.language.countdownLanguage = language
        return UIModel.RenderSettings(settings, locale: locale)
    }

    // Regression for the E1 bug: the old predicate was always true (wrong direction, read the
    // input locale, and `!map.isEmpty` never empties). Only Arabic/Hebrew/Farsi — scripts without
    // capitals — get the larger label ratio, keyed off the resolved countdown locale.
    @Test func `enlarges labels only for non-capitalized scripts`() {
        #expect(render(language: .arabic).isNeedFixLabelSize)
        #expect(render(language: .hebrew).isNeedFixLabelSize)
        #expect(render(language: .farsi).isNeedFixLabelSize)

        #expect(!render(language: .english).isNeedFixLabelSize)
        #expect(!render(language: .russian).isNeedFixLabelSize)

        // Devanagari (hi/sa) intentionally NOT enlarged yet — revisit in the Step-3 visual pass.
        #expect(!render(language: .hindi).isNeedFixLabelSize)

        // Automatic on a Latin Mac region stays standard (proves it reads `countdownLocale`).
        #expect(!render(language: .automatic).isNeedFixLabelSize)
    }
}
