//
//  LocalStore.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol LocalStore {
    func load() -> Settings?
    func save(_ settings: Settings)
}
