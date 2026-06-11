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
        Section {
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
            .help(Text(Resources.Language.countdownHint))

            VStack(alignment: .leading, spacing: .Spacing.small) {
                Text(Resources.Language.translationDisclaimer)
                    .subtitleFont
                if let issuesURL = AppSettings.issuesURL {
                    Link(destination: issuesURL) {
                        Text(Resources.Language.reportIssue)
                    }
                    .font(.caption)
                }
            }
        } header: {
            Text(Resources.Language.title)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        LanguageSectionView(settings: .constant(.default))
    }
    .padding()
}
