//
//  MinimalDevApp.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

@main
struct MinimalDevApp: App {
    var body: some Scene {
        WindowGroup("MinimalCountdown Debug Preview") {
            ScreenSaverRepresentable()
                .ignoresSafeArea()
        }
        .commands {
            CommandGroup(after: .appSettings) {
                Button("Settings…") {
                    appDelegate.openSettings()
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }
    }
}

