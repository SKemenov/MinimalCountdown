//
//  AppearancePicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearancePicker: View {
    typealias StyleType = StyleElement
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
        HStack(alignment: .top, spacing: .zero) {
            pickerTitle

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
    }
}

private extension AppearancePicker {
    var pickerTitle: some View {
        HStack(spacing: .zero) {
            Text(titleResource)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    func changeSelection(to selected: StyleType) {
        withAnimation { currentSettings.style = selected }
    }

    func createAppearance(for style: StyleElement) -> some View {
        var styleSettings = currentSettings
        styleSettings.style = style

        return VStack(alignment: .center, spacing: .Spacing.xSmall) {
            ZStack(alignment: .center) {
                showSelection(for: style)
                showCountdownView(settings: styleSettings)
            }
            appearanceLabel(for: style)
        }
    }

    func showSelection(for style: StyleElement) -> some View {
        RoundedRectangle(cornerRadius: .Spacing.medium)
            .stroke(style.id == currentSettings.style.id ? Color.accentColor : .clear, lineWidth: .Border.medium)
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

    func appearanceLabel(for style: StyleElement) -> some View {
        HStack(alignment: .center) {
            Text(style.appearanceLabel)
                .font(.caption)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .fontWeight(style.id == currentSettings.style.id ? .bold : .regular)
                .foregroundStyle(style.id == currentSettings.style.id ? .primary : .secondary)
        }
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
