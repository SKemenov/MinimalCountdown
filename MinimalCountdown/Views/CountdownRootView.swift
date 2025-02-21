//
//  CountdownRootView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct CountdownRootView: View {
    let clock: CountdownClock
    let settingsManager: SettingsManager
    let isPreview: Bool

    var body: some View {
        CountdownWindow(
            now: clock.now,
            settings: settingsManager.settings,
            isPreview: isPreview
        )
    }
}
