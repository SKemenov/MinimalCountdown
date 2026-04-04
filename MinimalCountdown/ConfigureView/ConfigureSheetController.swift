//
//  ConfigureSheetController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI
import OSLog

class ConfigureSheetController: NSObject {

    private(set) var hostingController: NSHostingController<AnyView>?
    private(set) var window: NSWindow?
    private let logger: Logger

    init(settingsManager: SettingsManager) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        super.init()

        let configView = ConfigurationWindow { [weak self] in
            self?.closeSheet()
        }
        .environment(settingsManager)

        hostingController = NSHostingController(rootView: AnyView(configView))
        window = NSWindow(contentViewController: hostingController!)
        window?.title = "ScreenSaver Preferences"
        window?.styleMask = [.titled, .closable]
        window?.isReleasedWhenClosed = false
        window?.level = .floating
        window?.center()
        logger.debug("Created ScreenSaver Preferences window")
    }

    private func closeSheet() {
        if let window, let sheetParent = window.sheetParent {
            logger.debug("Closing ScreenSaver Preferences sheet")
            sheetParent.endSheet(window)
        } else {
            logger.debug("Closing ScreenSaver Preferences window")
            window?.close()
        }
    }
}
