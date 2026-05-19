//
//  EffectStyle.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum EffectStyle: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case none = 0, glow, innerGlow, backlight, blur

    // safe and un-optional, defaults to .none
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .none
    }
}

extension EffectStyle {
    var id: Self { self }

    var label: String {
        (self == .innerGlow ? "Inner Glow" : String(describing: self)).capitalized
    }
}
