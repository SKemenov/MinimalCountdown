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
    @Binding var currentSettings: SaverSettings
    private let contentStyles: [StyleType]
    @State private var pickerNow: Date = Date()

    init(
        _ titleResource: LocalizedStringResource,
        currentSettings: Binding<SaverSettings>,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self.titleResource = titleResource
        self._currentSettings = currentSettings
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
                Text(style.appearanceLabel)
                    .font(.caption)
                    .fontWeight(isActive(style) ? .bold : .regular)
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
        style.rawValue <= currentSettings.style.rawValue
    }

    func changeSelection(to selected: StyleType) {
        withAnimation { currentSettings.style = selected }
    }

    func createAppearance(for style: StyleType) -> some View {
        var styleSettings = currentSettings
        styleSettings.style = style

        return ZStack(alignment: .center) {
            showSelection(for: style)
            showCountdownView(settings: styleSettings)
        }
    }

    func showSelection(for style: StyleType) -> some View {
        RoundedRectangle(cornerRadius: .Spacing.medium)
            .stroke(style == currentSettings.style ? Color.accentColor : .clear, lineWidth: .Border.medium)
            .frame(width: .Sizes.appearanceWidth + .Spacing.xLarge, height: .Sizes.appearanceHeight + .Spacing.xLarge)
    }

    func showCountdownView(settings: SaverSettings) -> some View {
        CountdownWindow(
            now: pickerNow,
            settings: settings,
            isPreview: true
        )
        .frame(width: .Sizes.appearanceWidth, height: .Sizes.appearanceHeight)
        .padding(.Spacing.small)
        .background(settings.backgroundColor.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
    }
}

#Preview("Dynamic") {
    @State @Previewable var settings = SaverSettings.default
    AppearancePicker("Appearance", currentSettings: $settings)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
