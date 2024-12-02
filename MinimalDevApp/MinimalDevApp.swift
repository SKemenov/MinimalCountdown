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
    }
}
