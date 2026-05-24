//
//  Typography.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct Typography: Codable, Equatable, Hashable {
    var weight: FontWeight
    var isRounded: Bool
    var numeralSystem: NumeralSystem = .automatic
}

extension Typography {
    // Settings written before the Numerals picker have no `numeralSystem` key — decode it
    // tolerantly so existing v2 files still load (no schema version bump needed).
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weight = try container.decode(FontWeight.self, forKey: .weight)
        isRounded = try container.decode(Bool.self, forKey: .isRounded)
        numeralSystem = try container.decodeIfPresent(NumeralSystem.self, forKey: .numeralSystem) ?? .automatic
    }
}
