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
    @State private var hoveredStyle: StyleType

    init(
        selection: Binding<Appearance>,
        in settings: SaverSettings,
        for contentStyles: [StyleType] = StyleType.allCases
    ) {
        self._selection = selection
        self.settings = settings
        self.contentStyles = contentStyles
        self.hoveredStyle = selection.wrappedValue.style
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.xSmall) {
            HStack(alignment: .top, spacing: .zero) {
                ForEach(contentStyles) { style in
                    AppearanceButton(
                        settings: settings,
                        style: style,
                        selection: $selection,
                        isHovered: style == hoveredStyle
                    )
                    .onHover { hoveredStyle = $0 ? style : selection.style }
                }
            }
            showAppearanceUnits
        }
        .onAppear { withAnimation(.none) { hoveredStyle = selection.style } }
    }
}

private extension AppearancePicker {
    var showAppearanceUnits: some View {
        Text(appearanceUnits)
            .font(.callout)
            .fontWeight(.regular)
            .foregroundStyle(.primary)
    }

    var appearanceUnits: String {
        StyleType.allCases
            .filter { $0 <= hoveredStyle }
            .map { String(localized: $0.label) }
            .formatted(.list(type: .and))
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
