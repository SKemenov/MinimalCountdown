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
        let manager = SettingsManager(saver: FileLocalStore())
        _settingsManager = State(initialValue: manager)
        settingsManager.load()
    }

    var body: some Scene {
        WindowGroup(Text(verbatim: "Minimal Countdown Preview")) {
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
            SettingsWindow()
                .environment(settingsManager)
        }
    }
}

private extension Scene {
    func extraMenu(isAnimating: Binding<Bool>, isTestPreview: Binding<Bool>) -> some Scene {
        commands {
            CommandMenu(Text(verbatim: "Debug Options")) {
                Toggle(isOn: isAnimating) {
                    Label {
                        Text(verbatim: "Run timer")
                    } icon: {
                        Image(systemName: "timer")
                    }
                }
                .help(Text(verbatim: "Run countdown in DevApp"))
                Toggle(isOn: isTestPreview) {
                    Label {
                        Text(verbatim: "Show for Preview")
                    } icon: {
                        Image(systemName: "repeat")
                    }

                }
                .help(Text(verbatim: "Show countdown as for Preview in DevApp"))
            }
        }
    }
}
