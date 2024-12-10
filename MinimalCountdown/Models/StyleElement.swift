//
//  StyleElement.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Enums

enum StyleElement: Int, CaseIterable, Identifiable, SafeIntDecodable {
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

    var menuLabel: String {
        switch self {
            case .days: String(describing: self).capitalized
            default: "+ " + String(describing: self).capitalized
        }
    }
}
