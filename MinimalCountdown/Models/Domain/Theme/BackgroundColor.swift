//
//  BackgroundColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum BackgroundColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable {
    case black = 0, white

    // safe and un-optional, defaults to .black
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .black
    }
}

extension BackgroundColor {
    var color: Color {
        switch self {
            case .black: .black
            case .white: .white
        }
    }

    var label: LocalizedStringResource {
        switch self {
            case .black: Resources.Labels.ColorExtendable.black
            case .white: Resources.Labels.ColorExtendable.white
        }
    }

    var id: Int { self.rawValue }
}
