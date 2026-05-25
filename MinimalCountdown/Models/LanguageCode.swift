//
//  LanguageCode.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

struct LanguageCode: Codable, Equatable, Hashable {
    var countdownLanguage: AppLanguage
    var settingsLanguage: AppLanguage
}
