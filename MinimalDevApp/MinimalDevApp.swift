//
//  MinimalDevApp.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

@main
struct MinimalDevApp: App {
    @State private var settingsManager: SettingsManager

    @AppStorage("isAnimating") var isAnimating: Bool = false
    @AppStorage("isTestPreview") var isTestPreview: Bool = false

    init() {
        let manager = SettingsManager(stores: [FileLocalStore()])
        _settingsManager = State(initialValue: manager)
        settingsManager.load()
    }

    var body: some Scene {
        WindowGroup("Minimal Countdown Preview") {
            PreviewWindow(
                isAnimating: $isAnimating,
                isTestPreview: $isTestPreview
            )
            .frame(minWidth: 400, minHeight: 400)
            .environment(settingsManager)
        }
        .windowResizability(.contentSize)
        .extraMenu(isAnimating: $isAnimating, isTestPreview: $isTestPreview)

        Settings {
            ConfigurationWindow()
                .environment(settingsManager)
        }
    }
}

private extension Scene {
    func extraMenu(isAnimating: Binding<Bool>, isTestPreview: Binding<Bool>) -> some Scene {
        commands {
            CommandMenu("Debug Options") {
                Toggle(isOn: isAnimating) {
                    Label("Run timer", systemImage: "timer")
                }
                .help("Run countdown in DevApp")
                Toggle(isOn: isTestPreview) {
                    Label("Show for Preview", systemImage: "repeat")
                }
                .help("Show countdown as for Preview in DevApp")
            }
        }
    }
}
