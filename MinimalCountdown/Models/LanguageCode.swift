//
//  LanguageCode.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct LanguageCode: Codable, Equatable, Hashable {
    var countdownLanguage: AppLanguage = .automatic
    var settingsLanguage: AppLanguage = .automatic
}
