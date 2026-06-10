//
//  SettingsSaver.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol SettingsSaver: SettingsLoader {
    func save(_ settings: SaverSettings) throws
}
