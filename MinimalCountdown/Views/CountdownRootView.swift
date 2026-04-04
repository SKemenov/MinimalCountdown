//
//  CountdownRootView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct CountdownRootView: View {
    let clock: CountdownClock
    let isPreview: Bool

    @Environment(SettingsManager.self) private var settingsManager

    var body: some View {
        CountdownWindow(
            now: clock.now,
            settings: settingsManager.settings,
            isPreview: isPreview
        )
    }
}
