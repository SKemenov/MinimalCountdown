//
//  ColorExtendable.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

protocol ColorExtendable: Identifiable, Equatable, Hashable {
    var label: LocalizedStringResource { get }
    var color: Color { get }
    var id: Int { get }
}

extension ColorExtendable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
