//
//  TitleFormattingTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
struct `Title Formatting Tests` {

    @Test func `empty When Hidden`() {
        #expect(UIModel.formattedTitle(Title(text: "Hello", isHidden: true)) == "")
    }

    @Test func `empty When Text Empty`() {
        #expect(UIModel.formattedTitle(Title(text: "", isHidden: false)) == "")
    }

    @Test func `uppercases Single Word`() {
        #expect(UIModel.formattedTitle(Title(text: "soon", isHidden: false)) == "SOON")
    }

    @Test func `joins Short Title With Double Space`() {
        #expect(UIModel.formattedTitle(Title(text: "see you soon", isHidden: false)) == "SEE  YOU  SOON")
    }

    @Test func `joins Long Title With Triple Space`() {
        let long = "count down to the grand opening"  // 31 chars > 30 → triple-space join
        let sui = UIModel.formattedTitle(Title(text: long, isHidden: false))
        #expect(sui.contains("   "))
        #expect(sui == long.uppercased().components(separatedBy: " ").joined(separator: "   "))
    }
}
