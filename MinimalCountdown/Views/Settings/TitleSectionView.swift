//
//  TitleSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TitleSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Title.title) {
            TextField(text: $settings.title.text, prompt: Text(Resources.Title.titlePrompt)) { Text(verbatim: "") }
                .accessibilityLabel(Text(Resources.Title.title))

            Divider()

            Toggle(isOn: $settings.title.isHidden) {
                Text(Resources.Title.hideTitle)
            }
            .accessibilityAddTraits(.isToggle)
            .hint(Resources.Title.hideTitleHint)
            .accessibilityElement(children: .combine)
        }
    }
}

#Preview {
    TitleSectionView(settings: .constant(.default))
}
