//
//  MinimalDevApp.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

@main
struct MinimalDevApp: App {
    @AppStorage("isAnimating") var isAnimating: Bool = false
    var body: some Scene {
        WindowGroup("Minimal Countdown Preview") {
            ScreenSaverRepresentable(isAnimating: $isAnimating)
        }
        .windowResizability(.contentSize)
     }
}

