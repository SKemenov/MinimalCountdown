//
//  AccentColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import AppKit

enum AccentColor: Int, CaseIterable, CaseNameable, SafeIntDecodable {
    case white = 0, red, pink, orange, yellow, green, mint, cyan, blue, indigo, purple

    var color: NSColor {
        switch self {
        case .white:  return .white
        case .red:    return .systemRed
        case .pink:   return .systemPink
        case .orange: return .systemOrange
        case .yellow: return .systemYellow
        case .green:  return .systemGreen
        case .mint:   return .systemMint
        case .cyan:   return .cyan
        case .blue:   return .systemBlue
        case .indigo: return .systemIndigo
        case .purple: return .systemPurple
        }
    }

    // safe and un-optional, defaults to .white
    init(_ rawValue: Int) {
        self = AccentColor(rawValue: rawValue) ?? .white
    }
}
