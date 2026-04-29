//
//  AppearanceStyle.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Enums

enum AppearanceStyle: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case days = 0, hours, minutes, seconds

    // safe and un-optional, defaults to .seconds (show all)
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .seconds
    }
}

extension AppearanceStyle {
    var id: Self { self }
    
    var label: String {
        String(describing: self).uppercased()
    }

    var appearanceLabel: String {
        (self == .days ? String(describing: self) : "+ " + String(describing: self))
            .capitalized
    }
}
