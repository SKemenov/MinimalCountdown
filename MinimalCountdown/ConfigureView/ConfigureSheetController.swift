//
//  ConfigureSheetController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

class ConfigureSheetController: NSObject {

    private(set) var hostingController: NSHostingController<ConfigurationView>?
    private(set) var window: NSWindow?

    init(settingsManager: SettingsManager) {
        super.init()

        let configView = ConfigurationView(settingsManager: settingsManager) { [weak self] in
            self?.closeSheet()
        }

        hostingController = NSHostingController(rootView: configView)
        window = NSWindow(contentViewController: hostingController!)
        window?.title = "ScreenSaver Preferences"
        window?.styleMask = [.titled, .closable]
        window?.isReleasedWhenClosed = false
        window?.level = .floating
        window?.center()
    }

    private func closeSheet() {
        if let window, let sheetParent = window.sheetParent {
            sheetParent.endSheet(window)
        } else {
            window?.close()
        }
    }
}
