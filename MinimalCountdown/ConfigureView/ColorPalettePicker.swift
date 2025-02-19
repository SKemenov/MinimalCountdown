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

            VStack(alignment: .leading, spacing: 2) {
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
            Text(markedColor.name)
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

//import SwiftUI
//
//struct ColorPalettePicker: View {
//    private let titleResource: LocalizedStringResource
//    @Binding var selection: any ColorExtendable
//    private let contentColors: [any ColorExtendable]
//
//    init(_ titleResource: LocalizedStringResource, selection: Binding<any ColorExtendable>, for contentColors: [any ColorExtendable]) {
//        self.titleResource = titleResource
//        self._selection = selection
//        self.contentColors = contentColors
//    }
//
//    var body: some View {
//        HStack(alignment: .top, spacing: .zero) {
//            Text("Color")
//            Spacer()
//                .frame(maxWidth: .infinity)
//            VStack(alignment: .leading) {
//                HStack(spacing: 4) {
//                    ForEach(ColorType.allCases, id: \.id) { current in
//                        Button(
//                            action: { action(for: current) },
//                            label: { createColorCircle(for: current) }
//                        )
//                        .buttonStyle(.plain)
//                    }
//                }
//
//                HStack {
//                    createSpaceBefore(for: selection)
//                    Text(selection.name)
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                    createSpaceAfter(for: selection)
//                }
//            }
//            .frame(maxWidth: .infinity)
//
//        }
//    }
//}
//
//private extension ColorPalettePicker {
//    var totalCount: Int {
//        contentColors.count
//    }
//
//    func action(for current: any ColorExtendable) {
//        withAnimation {
//            selection = current
//        }
//    }
//
//    func createColorCircle(for current: any ColorExtendable) -> some View {
//        ZStack(alignment: .center) {
//            Circle()
//                .foregroundStyle(current.color)
//                .frame(width: 20, height: 20)
//
//            if current.color == .white && current.color != selection.color {
//                Circle()
//                    .stroke(.secondary, lineWidth: 1)
//                    .frame(width: 20, height: 20)
//            }
//            Circle()
//                .stroke(current.color == selection.color ? Color.accentColor : .clear, lineWidth: 3)
//                .frame(width: 26, height: 26)
//        }
//    }
//
//    func findIndex(for colorCase: any ColorExtendable) -> Int {
//        contentColors.firstIndex(where: { $0.color == colorCase.color }) ?? 0
//    }
//
//    @ViewBuilder
//    func createSpaceBefore(for colorCase: any ColorExtendable) -> some View {
//        ForEach(0..<findIndex(for: colorCase), id: \.self) { _ in
//            Spacer()
//        }
//    }
//
//    func createSpaceAfter(for colorCase: any ColorExtendable) -> some View {
//        ForEach(findIndex(for: colorCase) + 1..<totalCount, id: \.self) { _ in
//            Spacer()
//        }
//    }
//}
//
//#Preview("Dynamic") {
//    @State @Previewable var settingsColor: any ColorExtendable = ColorType.red
//    ColorPalettePicker("Color", selection: $settingsColor, for: ColorType.allCases)
//        .padding(8)
//        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
//        .padding(8)
//}
//
//#Preview("Accent Static") {
//    let colors = ColorType.allCases
//    VStack(alignment: .leading, spacing: 8) {
//        Text("Static").font(.headline)
//        ForEach(colors) { current in
//            ColorPalettePicker("Accent Color", selection: .constant(current), for: colors)
//        }
//        .padding(4)
//        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
//    }
//    .padding(4)
//    .frame(width: 512, height: 760)
//}
//
//#Preview("Background Static") {
//    let colors = BackgroundColor.allCases
//    VStack(alignment: .leading, spacing: 8) {
//        Text("Static").font(.headline)
//        ForEach(colors) { current in
//            ColorPalettePicker("Background Color", selection: .constant(current), for: colors)
//        }
//        .padding(4)
//        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
//    }
//    .padding(4)
//    .frame(width: 512, height: 760)
//}
