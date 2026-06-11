//
//  NumeralSystem.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum NumeralSystem: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable {
    case automatic = 0, latin, arabic, persian, devanagari
}

extension NumeralSystem {
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .automatic
    }

    var id: Self { self }

    /// `nil` for `.automatic` — the caller falls back to the resolved locale's own numbering
    /// system (UAE → Latin, Egypt → Arabic). The explicit cases override that.
    var numberingSystem: Locale.NumberingSystem? {
        switch self {
            case .automatic: nil
            case .latin: Locale.NumberingSystem("latn")
            case .arabic: Locale.NumberingSystem("arab")
            case .persian: Locale.NumberingSystem("arabext")
            case .devanagari: Locale.NumberingSystem("deva")
        }
    }

    var label: LocalizedStringResource {
        switch self {
            case .automatic: Resources.Labels.NumeralSystem.automatic
            case .latin: Resources.Labels.NumeralSystem.latin
            case .arabic: Resources.Labels.NumeralSystem.arabic
            case .persian: Resources.Labels.NumeralSystem.persian
            case .devanagari: Resources.Labels.NumeralSystem.devanagari
        }
    }
}
