//
//  EffectStyle.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum EffectStyle: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case none = 0, shadow, innerShadow, backlight, blur

    // safe and un-optional, defaults to .none
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .none
    }
}

extension EffectStyle {
    var id: Self { self }
}
