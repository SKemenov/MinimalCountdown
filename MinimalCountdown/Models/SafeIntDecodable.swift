//
//  SafeIntDecodable.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol SafeIntDecodable: RawRepresentable, Codable where RawValue == Int {
    init(_ rawValue: Int)
}

extension SafeIntDecodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = Self(try container.decode(Int.self))
    }
}
