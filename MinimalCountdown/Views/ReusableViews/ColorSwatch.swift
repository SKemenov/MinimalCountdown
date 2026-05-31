//
//  ColorSwatch.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ColorSwatch: View {
    typealias ColorType = AccentColor
    let currentColor: ColorType
    var isSelected: Bool

    init(_ currentColor: ColorType, isSelected: Bool) {
        self.currentColor = currentColor
        self.isSelected = isSelected
    }

    var body: some View {
        ZStack(alignment: .center) {
            swatch
            circleForWhite
            circleForSelected
        }
        .padding(.horizontal, .Spacing.xxSmall)
    }
}

private extension ColorSwatch {
    var swatch: some View {
        Circle()
            .foregroundStyle(currentColor.color)
            .frame(width: .Sizes.colorSwatch, height: .Sizes.colorSwatch)
    }

    @ViewBuilder
    var circleForWhite: some View {
        if currentColor.color == .white && !isSelected {
            Circle()
                .stroke(.secondary, lineWidth: .Border.small)
                .frame(width: .Sizes.colorSwatch, height: .Sizes.colorSwatch)
        }
    }

    var circleForSelected: some View {
        Circle()
            .stroke(isSelected ? Color.accentColor : .clear, lineWidth: .Border.medium)
            .frame(width: .Sizes.colorSwatch + .Spacing.small, height: .Sizes.colorSwatch + .Spacing.small)
    }
}

#Preview {
    ColorSwatch(.blue, isSelected: false)
}
