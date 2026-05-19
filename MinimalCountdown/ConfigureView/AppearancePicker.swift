//
//  AppearancePicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearancePicker: View {
    typealias StyleType = AppearanceStyle
    private let titleResource: String
    private let contentStyles: [StyleType]
    private let settings: SaverSettings
    @Binding var selection: Appearance
    @State private var pickerNow: Date = Date()

    init(
        _ titleResource: String,
        selection: Binding<Appearance>,
        in settings: SaverSettings,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self.titleResource = titleResource
        self._selection = selection
        self.settings = settings
        self.contentStyles = contentStyles
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.xSmall) {
            Text(titleResource)

            HStack(alignment: .top, spacing: .zero) {
                pickerLabel
                pickerButtons
            }
        }
    }
}

private extension AppearancePicker {
    var pickerLabel: some View {
        VStack(alignment: .leading, spacing: .Spacing.xxSmall) {
            ForEach(contentStyles) { style in
                Text(isActive(style) ? style.appearanceActive : style.appearanceInactive)
                    .font(.caption)
                    .foregroundStyle(isActive(style) ? .secondary : .tertiary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var pickerButtons: some View {
        ForEach(contentStyles) { current in
            Button(
                action: { changeSelection(to: current) },
                label: { createAppearance(for: current) }
            )
            .buttonStyle(.plain)
            .padding(.horizontal, .Spacing.xxSmall)
            .contentShape(Rectangle())
        }
    }

    func isActive(_ style: StyleType) -> Bool {
        style <= selection.style
    }

    func changeSelection(to selected: StyleType) {
        withAnimation { selection.style = selected }
    }

    func createAppearance(for style: StyleType) -> some View {
        ZStack(alignment: .center) {
            showSelection(for: style)
            showCountdownView(for: style)
        }
    }

    func showSelection(for style: StyleType) -> some View {
        RoundedRectangle(cornerRadius: .Spacing.medium)
            .stroke(style == selection.style ? Color.accentColor : .clear, lineWidth: .Border.medium)
            .frame(width: .Sizes.appearanceWidth + .Spacing.xLarge, height: .Sizes.appearanceHeight + .Spacing.xLarge)
    }

    func showCountdownView(for style: StyleType) -> some View {
        CountdownWindow(
            now: pickerNow,
            settings: makeSettings(for: style),
            isPreview: true
        )
        .frame(width: .Sizes.appearanceWidth, height: .Sizes.appearanceHeight)
        .padding(.Spacing.small)
        .background(settings.theme.background.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
    }

    func makeSettings(for style: StyleType) -> SaverSettings {
        var appearanceSettings = settings
        appearanceSettings.appearance.style = style
        return appearanceSettings
    }
}

#Preview("List") {
    @State @Previewable var settings = SaverSettings.default
    AppearancePicker("Appearance", selection: $settings.appearance, in: settings)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}

// MARK: - Tile-style picker (Phase 7 candidate, A/B against AppearancePicker above)

struct AppearancePicker1: View {
    typealias StyleType = AppearanceStyle
    private let titleResource: String
    private let contentStyles: [StyleType]
    private let settings: SaverSettings
    @Binding var selection: Appearance
    @State private var pickerNow: Date = Date()
    @State private var markedStyle: StyleType

    init(
        _ titleResource: String,
        selection: Binding<Appearance>,
        in settings: SaverSettings,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self.titleResource = titleResource
        self._selection = selection
        self.settings = settings
        self.contentStyles = contentStyles
        self.markedStyle = selection.wrappedValue.style
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.xSmall) {
            pickerTitle
            pickerButtons
        }
        .onAppear { withAnimation(.none) { markedStyle = selection.style } }
    }
}

private extension AppearancePicker1 {
    var pickerTitle: some View {
        Text(titleResource)
            .font(.body)
            .foregroundStyle(.primary)
    }

    var pickerButtons: some View {
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
        .padding(.horizontal, -.Spacing.xxSmall)
    }

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
        Text(isHover(style) ? style.appearanceActive : style.appearanceInactive)
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
            .frame(
                width: .Sizes.appearanceWidth + .Sizes.appearanceTileExtraWidth + .Spacing.xLarge,
                height: .Sizes.appearanceHeight + .Spacing.xLarge
            )
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
        .frame(width: .Sizes.appearanceWidth + .Sizes.appearanceTileExtraWidth, height: .Sizes.appearanceHeight)
        .padding(.Spacing.small)
        .background(settings.theme.background.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
    }
}

#Preview("Tile") {
    @State @Previewable var settings = SaverSettings.default
    AppearancePicker1("Appearance", selection: $settings.appearance, in: settings)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
