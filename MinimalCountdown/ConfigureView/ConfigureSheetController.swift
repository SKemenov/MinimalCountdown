//
//  ConfigureSheetController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import AppKit

final class ConfigureSheetController: NSObject {
    var window: NSWindow!

    init(settingsManager: SettingsManager) {
        super.init()
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
            styleMask: [.closable, .titled],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "configureSheet"
        window.contentViewController = ConfigureViewController(settingsManager: settingsManager)
        window.makeKeyAndOrderFront(nil)
    }
}
