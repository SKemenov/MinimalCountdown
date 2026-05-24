//
//  PreviewWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct PreviewWindow: View {
    @Binding var isAnimating: Bool
    @Binding var isTestPreview: Bool
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(\.locale) private var locale

    var body: some View {
        if isAnimating {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                CountdownWindow(
                    now: context.date,
                    settings: settingsManager.settings,
                    locale: locale,
                    isPreview: isTestPreview
                )
            }
        } else {
            CountdownWindow(
                now: Date(),
                settings: settingsManager.settings,
                locale: locale,
                isPreview: isTestPreview
            )
        }
    }
}

#if DEBUG
#Preview("Animated") {
    @State @Previewable var manager = SettingsManager(saver: MockInMemoryLocalStore(initial: .preview))
    PreviewWindow(
        isAnimating: .constant(true),
        isTestPreview: .constant(false)
    )
    .environment(manager)
    .onAppear(perform: manager.load)
}

#Preview("Static") {
    @State @Previewable var manager = SettingsManager(saver: MockInMemoryLocalStore(initial: .preview))
    PreviewWindow(
        isAnimating: .constant(false),
        isTestPreview: .constant(false)
    )
    .environment(manager)
    .onAppear(perform: manager.load)
}
#endif
