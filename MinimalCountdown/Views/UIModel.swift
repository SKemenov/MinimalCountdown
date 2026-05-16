//
//  UIModel.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

enum UIModel {
    struct RenderSettings {
        let digitsColor: Color
        let textsColor: Color
        let digitsWeight: Font.Weight
        let digitsDesign: Font.Design
        let isLabelHidden: Bool

        init(_ settings: SaverSettings) {
            let theme = settings.theme
            digitsColor = theme.accent.color.opacity(theme.brightness.digitsOpacity)
            textsColor = theme.accent.color.opacity(theme.brightness.textsOpacity)
            digitsWeight = settings.typography.weight.swiftUIWeight
            digitsDesign = settings.typography.isRounded ? .rounded : .default
            isLabelHidden = settings.appearance.isLabelHidden
        }
    }

    struct Element {
        let digits: String
        let label: String
        let size: CGFloat
        let render: RenderSettings
    }

    struct TextElement {
        let text: String
        let size: CGFloat
        let color: Color
        var weight: Font.Weight = .ultraLight
        var design: Font.Design = .default
    }

    static func formattedTitle(_ title: Title) -> String {
        guard !title.isHidden, !title.text.isEmpty else { return "" }
        let string = title.text.uppercased()
        let words = string.components(separatedBy: " ")
        let separator = string.count <= 30 ? "  " : "   "
        return words.joined(separator: separator)
    }
}
