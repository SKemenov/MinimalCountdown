//
//  AppearanceStyle.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Enums

enum AppearanceStyle: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Comparable, Hashable {
    case days = 0, hours, minutes, seconds

    // safe and un-optional, defaults to .seconds (show all)
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .seconds
    }
}

extension AppearanceStyle {
    var id: Self { self }

    static func < (lhs: AppearanceStyle, rhs: AppearanceStyle) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    var label: String {
        String(describing: self).uppercased()
    }

    var appearanceActive: String {
        (self == .days ? String(describing: self) : "+ " + String(describing: self))
            .capitalized
    }

    var appearanceInactive: String {
        (self == .days ? String(describing: self) : "   " + String(describing: self)) // triple spaces
            .capitalized
    }
}
