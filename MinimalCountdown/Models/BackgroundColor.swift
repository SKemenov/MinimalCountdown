//
//  BackgroundColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import AppKit

enum BackgroundColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable {
    case black = 0, white

    // safe and un-optional, defaults to .black
    init(_ rawValue: Int) {
        self = BackgroundColor(rawValue: rawValue) ?? .black
    }
}

extension BackgroundColor {
    var nsColor: NSColor {
        switch self {
            case .black: .black
            case .white: .white
        }
    }

    var id: Int { self.rawValue }
}
