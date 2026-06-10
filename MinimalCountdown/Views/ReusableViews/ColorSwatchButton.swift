//
//  ColorSwatchButton.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ColorSwatchButton: View {
    typealias ColorType = AccentColor
    var currentColor: ColorType
    var isHovered: Bool
    @Binding var selection: ColorType

    init(_ currentColor: ColorType, selection: Binding<ColorType>, isHovered: Bool) {
        self.currentColor = currentColor
        self._selection = selection
        self.isHovered = isHovered
    }

    var body: some View {
        Button(action: changeColor) {
            VStack(spacing: .Spacing.xSmall) {
                ColorSwatch(currentColor, isSelected: currentColor == selection)
                swatchName
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

private extension ColorSwatchButton {
    func changeColor() {
        withAnimation { selection = currentColor }
    }

    var swatchName: some View {
        Text(currentColor.label)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize()
            .frame(width: .zero)
            .opacity(isHovered ? 1 : 0)
    }
}

#Preview {
    ColorSwatchButton(.cyan, selection: .constant(.white), isHovered: false)
}
