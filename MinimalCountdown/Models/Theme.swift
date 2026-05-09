//
//  Theme.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct Theme: Codable, Equatable, Hashable {
    var accent: AccentColor
    var background: BackgroundColor
    var brightness: Brightness
    var effect: EffectStyle
    var effectColor: AccentColor
}

extension Theme {
    var digitsColor: Color { accent.color.opacity(brightness.digitsOpacity) }
    var textsColor: Color  { accent.color.opacity(brightness.textsOpacity)  }
}
