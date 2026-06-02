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
        Section {
            ColorPalettePicker(Resources.Theme.color, selection: $settings.theme.accent)
            BrightnessSlider(Resources.Theme.brightness, selection: $settings.theme.brightness)
        } header: {
            Text(Resources.Theme.title)
        }
    }
}

#Preview {
    ThemeSectionView(settings: .constant(.default))
}
