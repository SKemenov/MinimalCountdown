//
//  StyleElement.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Enums

enum StyleElement: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case days = 0, hours, minutes, seconds

    // safe and un-optional, defaults to .seconds (show all)
    init(_ rawValue: Int) {
        self = StyleElement(rawValue: rawValue) ?? .seconds
    }
}

extension StyleElement {
    var id: Self { self }
    
    var label: String {
        String(describing: self).uppercased()
    }

    var string: String {
        String(describing: self).capitalized
    }

    var appearanceLabel: String {
        switch self {
            case .days: Self.days.string
            case .hours: [Self.days, Self.hours].map { $0.string }.formatted(.list(type: .and))
            case .minutes: [Self.days, Self.hours, Self.minutes].map { $0.string }.formatted(.list(type: .and))
            case .seconds: "All Elements"
        }
    }
}
