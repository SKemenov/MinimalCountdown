//
//  ColorPalettePicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ColorPalettePicker: View {
    typealias ColorType = AccentColor
    private let titleResource: LocalizedStringResource
    @Binding var selection: ColorType
    @State private var hoverColor: ColorType
    private let contentColors: [ColorType]

    init(
        _ titleResource: LocalizedStringResource,
        selection: Binding<ColorType>,
        for contentColors: [ColorType] = ColorType.allCases
    ) {
        self.titleResource = titleResource
        self._selection = selection
        self.hoverColor = selection.wrappedValue
        self.contentColors = contentColors
    }

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            pickerTitle
            colorElements
        }
        .task(id: selection) { hoverColor = selection }
    }
}

private extension ColorPalettePicker {
    var pickerTitle: some View {
        HStack {
            Text(titleResource)
            Spacer()
                .frame(maxWidth: .infinity)
        }
    }

    var colorElements: some View {
        HStack(spacing: .zero) {
            ForEach(contentColors) { current in
                ColorSwatchButton(current, selection: $selection, isHovered: current == hoverColor)
                    .onHover { hoverColor = $0 ? current : selection }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Dynamic") {
    @State @Previewable var settingsColor = AccentColor.red
    ColorPalettePicker("Color", selection: $settingsColor)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}

#Preview("Accent Static") {
    let colors = AccentColor.allCases
    VStack(alignment: .leading, spacing: .Spacing.medium) {
        Text("Static").font(.headline)
        ForEach(colors) { current in
            ColorPalettePicker("Accent Color", selection: .constant(current))
        }
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
    }
    .padding(.Spacing.medium)
    .frame(width: .Sizes.settingsWidth, height: 760)
}
