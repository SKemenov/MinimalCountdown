//
//  JSONDecoder+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

extension JSONDecoder {
    static func saverDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
