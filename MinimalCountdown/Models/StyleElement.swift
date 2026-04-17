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

    var appearanceLabel: String {
        (self == .days ? String(describing: self) : "+ " + String(describing: self))
            .capitalized
    }
}
