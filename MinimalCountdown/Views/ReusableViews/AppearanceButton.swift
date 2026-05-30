//
//  AppearanceButton.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearanceButton: View {
    typealias StyleType = AppearanceStyle
    private var styleSettings: SaverSettings
    private var style: StyleType
    private var isHovered: Bool
    @Binding var selection: Appearance
    @State private var pickerNow: Date = Date()

    init(settings: SaverSettings, style: StyleType, selection: Binding<Appearance>, isHovered: Bool) {
        styleSettings = settings
        self.style = style
        styleSettings.appearance.style = style
        self._selection = selection
        self.isHovered = isHovered
    }

    var body: some View {
        Button(action: changeSelection) {
            ZStack(alignment: .center) {
                showBorder
                showCountdownView
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, .Spacing.xxSmall)
        .contentShape(Rectangle())
    }
}

private extension AppearanceButton {
    func changeSelection() {
        selection.style = style
    }

    var showBorder: some View {
        RoundedRectangle(cornerRadius: .Spacing.medium)
            .stroke(
                style == selection.style ? Color.accentColor : isHovered ? .secondary : .clear,
                lineWidth: .Border.medium
            )
            .frame(height: .Sizes.appearanceHeight + .Spacing.medium)
    }

    var showCountdownView: some View {
        CountdownWindow(
            now: pickerNow,
            settings: styleSettings,
            isPreview: true
        )
        .padding(.Spacing.small)
        .frame(height: .Sizes.appearanceHeight)
        .background(styleSettings.theme.background.color, in: RoundedRectangle(cornerRadius: .Spacing.small))
        .padding(.horizontal, .Spacing.xSmall)
    }
}

#Preview {
    AppearanceButton(
        settings: SaverSettings.default,
        style: .minutes,
        selection: .constant(.init(style: .hours, isLabelHidden: false)),
        isHovered: false
    )
}
