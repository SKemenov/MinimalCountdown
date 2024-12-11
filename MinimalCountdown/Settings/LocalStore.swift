//
//  LocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol LocalStore {
    func load() -> SaverSettings?
    func save(_ settings: SaverSettings)
}
