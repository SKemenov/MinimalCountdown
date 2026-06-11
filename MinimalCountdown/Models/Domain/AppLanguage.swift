//
//  AppLanguage.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum AppLanguage: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case automatic = 0
    case english
    case spanish
    case german
    case french
    case russian
    case hebrew
    case arabic
    case farsi
    case hindi
    case sanskrit
}

extension AppLanguage {
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .automatic
    }

    var id: Self { self }

    var label: LocalizedStringResource {
        switch self {
            case .automatic: Resources.Labels.AppLanguage.automatic
            case .english:   Resources.Labels.AppLanguage.english
            case .spanish:   Resources.Labels.AppLanguage.spanish
            case .german:    Resources.Labels.AppLanguage.german
            case .french:    Resources.Labels.AppLanguage.french
            case .russian:   Resources.Labels.AppLanguage.russian
            case .hebrew:    Resources.Labels.AppLanguage.hebrew
            case .arabic:    Resources.Labels.AppLanguage.arabic
            case .farsi:     Resources.Labels.AppLanguage.farsi
            case .hindi:     Resources.Labels.AppLanguage.hindi
            case .sanskrit:  Resources.Labels.AppLanguage.sanskrit
        }
    }

    var languageCode: String? {
        switch self {
            case .automatic: nil
            case .english: "en"
            case .spanish: "es"
            case .german: "de"
            case .french: "fr"
            case .russian: "ru"
            case .hebrew: "he"
            case .arabic: "ar"
            case .farsi: "fa"
            case .hindi: "hi"
            case .sanskrit: "sa"
        }
    }
}
