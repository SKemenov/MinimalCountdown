//
//  MinimalDevApp.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

@main
struct MinimalDevApp: App {
    @NSApplicationDelegateAdaptor(DevAppDelegate.self) var appDelegate

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

class DevAppDelegate: NSObject, NSApplicationDelegate {
    private var settingsManager: SettingsManager?
    private var settingsSheet: NSWindow?

    @objc func openSettings() {
        guard
            let mainWindow = NSApp.mainWindow ?? NSApp.windows.first,
            let fileStore = FileStore(),
            let defaultsStore = DefaultsStore() else { return }

        let manager = SettingsManager(stores: [fileStore, defaultsStore])
        manager.load()
        settingsManager = manager

        let viewController = ConfigureViewController(settingsManager: manager)
        let sheet = NSWindow(contentViewController: viewController)
        sheet.title = "Settings"
        settingsSheet = sheet

        mainWindow.beginSheet(sheet) { [weak self] _ in
            self?.settingsSheet = nil
            self?.settingsManager = nil
        }
    }
}
