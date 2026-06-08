//
//  ThemeSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ThemeSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Theme.title) {
            ColorPalettePicker(Resources.Theme.color, selection: $settings.theme.accent)

            Divider()

            BrightnessSlider(Resources.Theme.brightness, selection: $settings.theme.brightness)
        }
    }
}

#Preview {
    ThemeSectionView(settings: .constant(.default))
}
