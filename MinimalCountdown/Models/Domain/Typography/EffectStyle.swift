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

    var label: LocalizedStringResource {
        switch self {
            case .none: Resources.Labels.EffectStyle.none
            case .glow: Resources.Labels.EffectStyle.glow
            case .innerGlow: Resources.Labels.EffectStyle.innerGlow
            case .backlight: Resources.Labels.EffectStyle.backlight
            case .blur: Resources.Labels.EffectStyle.blur
        }
    }
}
