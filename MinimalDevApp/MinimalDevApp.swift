//
//  MinimalDevApp.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

@main
struct MinimalDevApp: App {
    private var settingsManager: SettingsManager

    @AppStorage("isAnimating") var isAnimating: Bool = false

    init() {
        settingsManager = SettingsManager(stores: Self.createStores())
    }

    var body: some Scene {
        WindowGroup("Minimal Countdown Preview") {
            ScreenSaverRepresentable(isAnimating: $isAnimating)
        }
        .windowResizability(.contentSize)
     }
    }
}

private extension MinimalDevApp {
    static func createStores() -> [LocalStore] {
        if let fileStore = FileStore(), let defaultsStore = DefaultsStore() {
            return [fileStore, defaultsStore]
        } else {
            return []
        }
    }
}

