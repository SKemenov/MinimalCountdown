//
//  SettingsLoader.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol SettingsLoader {
    func load() -> SaverSettings?
}
