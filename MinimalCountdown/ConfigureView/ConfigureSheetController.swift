//
//  ConfigureSheetController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 26.02.2024.
//

import AppKit

final class ConfigureSheetController : NSObject {
    var window: NSWindow!

    override init() {
        super.init()
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
            styleMask: [.closable, .titled],
            backing: .buffered, defer: false)
        window.center()
        window.title = "configureSheet"
        window.contentViewController = ConfigureViewController()
        window.makeKeyAndOrderFront(nil)
    }
}
