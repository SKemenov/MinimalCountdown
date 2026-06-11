//
//  AccentColor.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum AccentColor: Int, CaseIterable, ColorExtendable, SafeIntDecodable {
    case white = 0, red, pink, orange, yellow, green, mint, cyan, blue, indigo, purple
}

extension AccentColor {
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .white
    }

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

    var label: LocalizedStringResource {
        switch self {
            case .white: Resources.Labels.ColorExtendable.white
            case .red: Resources.Labels.ColorExtendable.red
            case .pink: Resources.Labels.ColorExtendable.pink
            case .orange: Resources.Labels.ColorExtendable.orange
            case .yellow: Resources.Labels.ColorExtendable.yellow
            case .green: Resources.Labels.ColorExtendable.green
            case .mint: Resources.Labels.ColorExtendable.mint
            case .cyan: Resources.Labels.ColorExtendable.cyan
            case .blue: Resources.Labels.ColorExtendable.blue
            case .indigo: Resources.Labels.ColorExtendable.indigo
            case .purple: Resources.Labels.ColorExtendable.purple
        }
    }

    var id: Int { self.rawValue }
}
