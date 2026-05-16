//
//  Theme.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct Theme: Codable, Equatable, Hashable {
    var accent: AccentColor
    var background: BackgroundColor
    var brightness: Brightness
    var effect: EffectStyle
    var effectColor: AccentColor
}
