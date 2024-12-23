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
        .extraMenu($isAnimating)

        Settings {
            ConfigurationView(settingsManager: settingsManager)
        }
    }
}

private extension MinimalDevApp {
    static func createStores() -> [LocalStore] {
        let ssDirectory = "~/Library/Containers/com.apple.ScreenSaver.Engine.legacyScreenSaver/Data/Library/Application Support"
        let url = URL(filePath: ssDirectory, directoryHint: .isDirectory)
        if let fileStore = FileStore(supportDirectory: url), let defaultsStore = DefaultsStore() {
            return [fileStore, defaultsStore]
        } else {
            return []
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
