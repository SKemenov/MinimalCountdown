//
//  AppearancePicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearancePicker: View {
    typealias StyleType = AppearanceStyle
    private let contentStyles: [StyleType]
    private let settings: SaverSettings
    @Binding var selection: Appearance
    @State private var pickerNow: Date = Date()
    @State private var markedStyle: StyleType

    init(
        selection: Binding<Appearance>,
        in settings: SaverSettings,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self._selection = selection
        self.settings = settings
        self.contentStyles = contentStyles
        self.markedStyle = selection.wrappedValue.style
    }

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            ForEach(contentStyles) { style in
                VStack(alignment: .center, spacing: .Spacing.xSmall) {
                    Button(
                        action: { changeSelection(to: style) },
                        label: { createAppearance(for: style) }
                    )
                    .buttonStyle(.plain)
                    .padding(.horizontal, .Spacing.xxSmall)

                    showLabel(for: style)
                }
                .contentShape(Rectangle())
                .onHover { markedStyle = $0 ? style : selection.style }
            }
        }
        .onAppear { withAnimation(.none) { markedStyle = selection.style } }
    }
}

private extension AppearancePicker {
    func isHover(_ style: StyleType) -> Bool {
        style <= markedStyle
    }

    func changeSelection(to selected: StyleType) {
        selection.style = selected
    }

    func createAppearance(for style: StyleType) -> some View {
        var styleSettings = settings
        styleSettings.appearance.style = style

        return ZStack(alignment: .center) {
            showSelection(for: style)
            showCountdownView(settings: styleSettings)
        }
    }

    func showLabel(for style: StyleType) -> some View {
        Text(style.label)
            .font(.callout)
            .fontWeight(isHover(style) ? .medium : .regular)
            .foregroundStyle(isHover(style) ? .primary : .secondary)
    }

    func showSelection(for style: StyleType) -> some View {
        RoundedRectangle(cornerRadius: .Spacing.medium)
            .stroke(
                selectBorderColor(for: style),
                lineWidth: .Border.medium
            )
            .frame(height: .Sizes.appearanceHeight + .Spacing.medium)
    }

    func selectBorderColor(for style: StyleType) -> Color {
        if style == selection.style {
            return Color.accentColor
        } else if style == markedStyle {
            return .secondary
        } else {
            return .clear
        }
    }

    func showCountdownView(settings: SaverSettings) -> some View {
        CountdownWindow(
            now: pickerNow,
            settings: settings,
            isPreview: true
        )
        .padding(.Spacing.small)
        .frame(height: .Sizes.appearanceHeight)
        .background(settings.theme.background.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
        .padding(.horizontal, .Spacing.xSmall)
    }
}

#Preview("Dynamic") {
    @State @Previewable var settings = SaverSettings.default
    AppearancePicker(selection: $settings.appearance, in: settings)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
