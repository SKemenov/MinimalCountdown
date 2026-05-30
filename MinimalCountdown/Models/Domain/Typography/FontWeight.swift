//
//  FontWeight.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum FontWeight: Int, CaseIterable, Identifiable, SafeIntDecodable, Equatable, Hashable, Comparable {
    case ultraLight = 0, thin, light, regular, medium, semibold, bold, heavy, black

    // safe and un-optional, defaults to .ultraLight
    init(_ rawValue: Int) {
        self = .init(rawValue: rawValue) ?? .ultraLight
    }
}

extension FontWeight {
    var id: Self { self }

    static func < (lhs: FontWeight, rhs: FontWeight) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    var swiftUIWeight: Font.Weight {
        switch self {
            case .ultraLight: .ultraLight
            case .thin: .thin
            case .light: .light
            case .regular: .regular
            case .medium: .medium
            case .semibold: .semibold
            case .bold: .bold
            case .heavy: .heavy
            case .black: .black
        }
    }

    var label: LocalizedStringResource {
        switch self {
            case .ultraLight: Resources.Labels.FontWeight.ultraLight
            case .thin: Resources.Labels.FontWeight.thin
            case .light: Resources.Labels.FontWeight.light
            case .regular: Resources.Labels.FontWeight.regular
            case .medium: Resources.Labels.FontWeight.medium
            case .semibold: Resources.Labels.FontWeight.semibold
            case .bold: Resources.Labels.FontWeight.bold
            case .heavy: Resources.Labels.FontWeight.heavy
            case .black: Resources.Labels.FontWeight.black
        }
    }
}
