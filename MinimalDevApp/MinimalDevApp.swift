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
        settingsManager = SettingsManager(stores: [FileStore()])
        settingsManager.load()
    }

    var body: some Scene {
        WindowGroup("Minimal Countdown Preview") {
            PreviewWindow(
                settingsManager: settingsManager,
                isAnimating: $isAnimating,
                isTestPreview: $isTestPreview
            )
            .frame(minWidth: 400, minHeight: 400)
        }
        .windowResizability(.contentSize)
        .extraMenu($isAnimating)

        Settings {
            ConfigurationView(settingsManager: settingsManager)
        }
    }
}

private extension Scene {
    func extraMenu(_ isAnimating: Binding<Bool>) -> some Scene {
        commands {
            CommandMenu("Debug Options") {
                Toggle(isOn: isAnimating) {
                    Label("Run timer", systemImage: "timer")
                }
                .help("Run countdown in DevApp")
            }
        }
    }
}
