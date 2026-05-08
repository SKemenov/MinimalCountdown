//
//  AppearancePicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearancePicker: View {
    typealias StyleType = AppearanceStyle
    private let titleResource: LocalizedStringResource
    private let contentStyles: [StyleType]
    private let theme: Theme
    @Binding var selection: Appearance
    @State private var pickerNow: Date = Date()

    init(
        _ titleResource: LocalizedStringResource,
        selection: Binding<Appearance>,
        theme: Theme,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self.titleResource = titleResource
        self._selection = selection
        self.theme = theme
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
            settings: miniSettings(for: style),
            isPreview: true
        )
        .frame(width: .Sizes.appearanceWidth, height: .Sizes.appearanceHeight)
        .padding(.Spacing.small)
        .background(theme.background.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
    }

    func miniSettings(for style: StyleType) -> SaverSettings {
        SaverSettings(
            appearance: .init(style: style, isLabelHidden: selection.isLabelHidden),
            schedule: SaverSettings.default.schedule,
            theme: theme,
            typography: SaverSettings.default.typography,
            title: SaverSettings.default.title
        )
    }
}

#Preview("Dynamic") {
    @State @Previewable var settings = SaverSettings.default
    AppearancePicker("Appearance", selection: $settings.appearance, theme: settings.theme)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
