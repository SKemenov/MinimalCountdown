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

    /// Base word only — views own the presentation transform (`.textCase(.uppercase)` on-screen).
    var label: String {
        switch self {
            case .days: Resources.Labels.AppearanceStyle.days
            case .hours: Resources.Labels.AppearanceStyle.hours
            case .minutes: Resources.Labels.AppearanceStyle.minutes
            case .seconds: Resources.Labels.AppearanceStyle.seconds
        }
    }
}
