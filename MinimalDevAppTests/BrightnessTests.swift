//
//  BrightnessTests.swift
//  MinimalDevAppTests
//
//  Created by Sergey Kemenov
//

import Testing
import Foundation
@testable import MinimalDevApp

@Suite
struct `Brightness Tests` {

    @Test func opacities() {
        #expect(Brightness.high.digitsOpacity == 1.0)
        #expect(Brightness.high.textsOpacity == 0.85)
        #expect(Brightness.medium.digitsOpacity == 0.85)
        #expect(Brightness.medium.textsOpacity == 0.7)
        #expect(Brightness.low.digitsOpacity == 0.7)
        #expect(Brightness.low.textsOpacity == 0.55)
    }

    @Test func `slider Value Round Trips`() {
        for sui in Brightness.allCases {
            #expect(sui.sliderValue == Double(sui.rawValue))
            #expect(Brightness(Int(sui.sliderValue)) == sui)  // the slider binding path
        }
    }
}
