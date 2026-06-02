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
        Section {
            AppearancePicker(selection: $settings.appearance, in: settings)

            hideLabelsToggle

            Text(Resources.Appearance.previewHint)
                .subtitleFont
        } header: {
            Text(Resources.Appearance.title)
        }
    }

    private var hideLabelsToggle: some View {
        Toggle(isOn: $settings.appearance.isLabelHidden) {
            Text(Resources.Appearance.hideLabels)
        }
        .help(Text(Resources.Appearance.hideLabelsHint))
    }
}

#Preview {
    AppearanceSectionView(settings: .constant(.default))
}
