//
//  BackgroundColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import AppKit

enum BackgroundColor: Int, CaseIterable, CaseNameable, SafeIntDecodable {
    case black = 0, white

    var color: NSColor {
        switch self {
        case .black: return .black
        case .white: return .white
        }
    }

    // safe and un-optional, defaults to .black
    init(_ rawValue: Int) {
        self = BackgroundColor(rawValue: rawValue) ?? .black
    }
}
