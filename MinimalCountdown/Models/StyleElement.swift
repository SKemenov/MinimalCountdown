//
//  StyleElement.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Enums

enum StyleElement: Int, CaseIterable, CaseNameable, SafeIntDecodable {
    case days = 0, hours, minutes, seconds

    // safe and un-optional, defaults to .seconds (show all)
    init(_ rawValue: Int) {
        self = StyleElement(rawValue: rawValue) ?? .seconds
    }
}
