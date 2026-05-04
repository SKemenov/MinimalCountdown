//
//  Brightness.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum Brightness: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case normal = 0, dim

    // safe and un-optional, defaults to .normal
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .normal
    }
}

extension Brightness {
    var id: Self { self }

    var digitsOpacity: Double { self == .normal ? 1.0 : 0.8 }
    var textsOpacity: Double  { self == .normal ? 0.7 : 0.5 }
}
