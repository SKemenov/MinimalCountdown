//
//  AccessibleSection.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

// TODO: - change VStack to Group(subviews:) and eliminate dividers in content, after migrating saver target to macOS 15+
/// A `Form` section whose rows are wrapped in a VoiceOver container.
///
/// In a grouped `Form` the native per-row grouping is lost to VoiceOver, so each
/// section here wraps its rows in a leading `VStack` marked `.contain` and labelled
/// with the section title; the visible header `Text` is hidden so its label doesn't
/// double up with the container's. Callers keep explicit `Divider()`s between rows
/// (`Group(subviews:)` auto-dividers would require macOS 15+, but the saver ships 14.6).
struct AccessibleSection<Content: View>: View {
    private let title: LocalizedStringResource
    private let content: Content

    init(_ title: LocalizedStringResource, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                content
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel(Text(title))
        } header: {
            Text(title)
                .accessibilityHidden(true)
        }
    }
}
