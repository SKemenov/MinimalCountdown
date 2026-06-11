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
    @Environment(\.locale) private var locale

    var body: some View {
        CountdownWindow(
            now: clock.now,
            settings: settingsManager.settings,
            locale: locale,
            isPreview: isPreview
        )
    }
}
