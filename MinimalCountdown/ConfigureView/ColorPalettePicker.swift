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
    @State private var markedColor: ColorType
    private let contentColors: [ColorType]

    init(
        _ titleResource: LocalizedStringResource,
        selection: Binding<ColorType>,
        for contentColors: [ColorType] = ColorType.allCases
    ) {
        self.titleResource = titleResource
        self._selection = selection
        self.markedColor = selection.wrappedValue
        self.contentColors = contentColors
    }

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            pickerTitle

            VStack(alignment: .leading, spacing: .Spacing.xxSmall) {
                colorElements
                colorName
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private extension ColorPalettePicker {
    var totalCount: Int {
        contentColors.count - 1
    }

    func findIndex(for colorCase: ColorType) -> Int {
        contentColors.firstIndex(where: { $0 == colorCase }) ?? 0
    }
    
    func createSpace(for colorCase: ColorType, isBefore: Bool) -> some View {
        let range = if isBefore {
            0..<findIndex(for: colorCase)
        } else {
            findIndex(for: colorCase)..<totalCount
        }
        return ForEach(range, id: \.self) { _ in
            Spacer()
        }
    }

    func changeColor(to current: ColorType) {
        withAnimation { selection = current }
    }

    func createColorCircle(for current: ColorType) -> some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundStyle(current.color)
                .frame(width: .Sizes.colorSelector, height: .Sizes.colorSelector)

            if current.color == .white && current.color != selection.color {
                Circle()
                    .stroke(.secondary, lineWidth: .Border.small)
                    .frame(width: .Sizes.colorSelector, height: .Sizes.colorSelector)
            }
            Circle()
                .stroke(current.color == selection.color ? Color.accentColor : .clear, lineWidth: .Border.medium)
                .frame(width: .Sizes.colorSelector + .Spacing.small, height: .Sizes.colorSelector + .Spacing.small)
        }
    }

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
                Button(
                    action: { changeColor(to: current) },
                    label: { createColorCircle(for: current) }
                )
                .buttonStyle(.plain)
                .padding(.horizontal, .Spacing.xxSmall)
                .contentShape(Rectangle())
                .onHover { markedColor = $0 ? current : selection }
            }
        }
    }

    var colorName: some View {
        HStack {
            createSpace(for: markedColor, isBefore: true)
            Text(markedColor.label)
                .font(.caption)
                .foregroundStyle(.secondary)
            createSpace(for: markedColor, isBefore: false)
        }
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
