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
        Section {
            TextField(text: $settings.title.text, prompt: Text(Resources.Title.titlePrompt)) { Text(verbatim: "") }

            Toggle(isOn: $settings.title.isHidden) {
                Text(Resources.Title.hideTitle)
            }
            .help(Text(Resources.Title.hideTitleHint))
        } header: {
            Text(Resources.Title.title)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        TitleSectionView(settings: .constant(.default))
    }
    .padding()
}
