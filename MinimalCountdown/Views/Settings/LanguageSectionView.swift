//
//  LanguageSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct LanguageSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Language.title) {
            Picker(selection: $settings.language) {
                Text(AppLanguage.automatic.label).tag(AppLanguage.automatic)

                if !UIModel.preferredLanguages.isEmpty {
                    ForEach(UIModel.preferredLanguages) { language in
                        Text(language.label).tag(language)
                    }
                }
                Divider()

                ForEach(UIModel.otherLanguages) { language in
                    Text(language.label).tag(language)
                }
            } label: {
                Text(Resources.Language.countdown)
            }
            .hint(Resources.Language.countdownHint)
            .accessibilityElement(children: .combine)

            Divider()

            Text(Resources.Language.translationDisclaimer)
                .subtitleFont
        }
    }
}

#Preview {
    LanguageSectionView(settings: .constant(.default))
}

