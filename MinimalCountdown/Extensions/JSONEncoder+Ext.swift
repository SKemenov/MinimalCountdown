//
//  JSONEncoder.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

extension JSONEncoder {
    static func saverEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }
}
