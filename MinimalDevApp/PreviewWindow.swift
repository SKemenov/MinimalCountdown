//
//  PreviewWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct PreviewWindow: View {
    let settingsManager: SettingsManager
    @Binding var isAnimating: Bool
    @Binding var isTestPreview: Bool

    var body: some View {
        if isAnimating {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                CountdownWindow(
                    now: context.date,
                    settings: settingsManager.settings,
                    isPreview: isTestPreview
                )
            }
        } else {
            CountdownWindow(
                now: Date(),
                settings: settingsManager.settings,
                isPreview: isTestPreview
            )
        }
    }
}

#Preview("Animated") {
    PreviewWindow(
        settingsManager: SettingsManager(stores: []),
        isAnimating: .constant(true),
        isTestPreview: .constant(false)
    )
}

#Preview("Static") {
    PreviewWindow(
        settingsManager: SettingsManager(stores: []),
        isAnimating: .constant(false),
        isTestPreview: .constant(false)
    )
}
