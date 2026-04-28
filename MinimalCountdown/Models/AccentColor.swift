//
//  AccentColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum AccentColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable {
    case white = 0, red, pink, orange, yellow, green, mint, cyan, blue, indigo, purple

    // safe and un-optional, defaults to .white
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .white
    }
}

extension AccentColor {
    var color: Color {
        switch self {
            case .white: .white
            case .red: .red
            case .pink: .pink
            case .orange: .orange
            case .yellow: .yellow
            case .green: .green
            case .mint: .mint
            case .cyan: .cyan
            case .blue: .blue
            case .indigo: .indigo
            case .purple: .purple
        }
    }

    var id: Int { self.rawValue }
}
