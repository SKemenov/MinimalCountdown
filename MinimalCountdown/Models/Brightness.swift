//
//  Brightness.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum Brightness: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case high = 0, medium, low

    // safe and un-optional, defaults to .high
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .high
    }
}

extension Brightness {
    var id: Self { self }

    var label: String { String(describing: self).capitalized }
    var iconName: String { "dial.\(self)" }

    var digitsOpacity: Double {
        switch self {
            case .high:   1.0
            case .medium: 0.85
            case .low:    0.7
        }
    }

    var textsOpacity: Double {
        switch self {
            case .high:   0.85
            case .medium: 0.7
            case .low:    0.55
        }
    }
}
