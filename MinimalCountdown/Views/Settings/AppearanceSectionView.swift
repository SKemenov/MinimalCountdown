//
//  AppearanceSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct AppearanceSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Appearance.title) {
            AppearancePicker(selection: $settings.appearance, in: settings)

            Divider()
            hideLabelsToggle
            Divider()

            Text(Resources.Appearance.previewHint)
                .subtitleFont
        }
    }

    private var hideLabelsToggle: some View {
        Toggle(isOn: $settings.appearance.isLabelHidden) {
            Text(Resources.Appearance.hideLabels)
        }
        .accessibilityAddTraits(.isToggle)
        .accessibilityElement(children: .combine)
        .hint(Resources.Appearance.hideLabelsHint)
    }
}

#Preview {
    AppearanceSectionView(settings: .constant(.default))
}
