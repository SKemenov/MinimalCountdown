//
//  SettingsWindowController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI
import OSLog

class SettingsWindowController: NSObject {

    private(set) var hostingController: NSHostingController<AnyView>?
    private(set) var window: NSWindow?
    private let logger: Logger

    init(settingsManager: SettingsManager) {
        logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        super.init()

        let settingsView = SettingsWindow { [weak self] in
            self?.closeSheet()
        }
        .environment(settingsManager)

        hostingController = NSHostingController(rootView: AnyView(settingsView))
        window = NSWindow(contentViewController: hostingController!)
        window?.title = "ScreenSaver Settings"
        window?.styleMask = [.titled, .closable]
        window?.isReleasedWhenClosed = false
        window?.level = .floating
        window?.center()
        logger.debug("Created ScreenSaver Settings window")
    }

    private func closeSheet() {
        if let window, let sheetParent = window.sheetParent {
            logger.debug("Closing ScreenSaver Settings sheet")
            sheetParent.endSheet(window)
        } else {
            logger.debug("Closing ScreenSaver Settings window")
            window?.close()
        }
    }
}
