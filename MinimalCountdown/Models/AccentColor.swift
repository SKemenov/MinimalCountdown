//
//  AccentColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import AppKit

enum AccentColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable {
//enum AccentColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable, Identifiable, Equatable, Hashable {
    case white = 0, red, pink, orange, yellow, green, mint, cyan, blue, indigo, purple

    // safe and un-optional, defaults to .white
    init(_ rawValue: Int) {
        self = AccentColor(rawValue: rawValue) ?? .white
    }
}

extension AccentColor {
    var nsColor: NSColor {
        switch self {
            case .white: .white
            case .red: .systemRed
            case .pink: .systemPink
            case .orange: .systemOrange
            case .yellow: .systemYellow
            case .green: .systemGreen
            case .mint: .systemMint
            case .cyan: .cyan
            case .blue: .systemBlue
            case .indigo: .systemIndigo
            case .purple: .systemPurple
        }
    }

    var id: Int { self.rawValue }
}
