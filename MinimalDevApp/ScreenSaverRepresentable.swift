//
//  ScreenSaverRepresentable.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI
import ScreenSaver
import OSLog

struct ScreenSaverRepresentable: NSViewRepresentable {
    @Binding var isAnimating: Bool
    private let logger: Logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))

    func makeNSView(context: Context) -> MinimalCountdownView {
        logger.log("Creating SwiftUI wrapper for screensaver")
        let view = MinimalCountdownView(frame: NSRect(x: 0, y: 0, width: 1600, height: 960), isPreview: false)!
        view.autoresizingMask = [.width, .height]
        view.window?.title = "Minimal Countdown Preview"

        if isAnimating {
            view.startAnimation()
            // Drive animateOneFrame() manually since we're outside the screensaver engine
            let timer = Timer.scheduledTimer(withTimeInterval: view.animationTimeInterval, repeats: true) { _ in
                view.animateOneFrame()
            }
            context.coordinator.timer = timer
        }
        let frame = "\(Int(view.frame.width))x\(Int(view.frame.height))"
        logger.log("Created SwiftUI wrapper for NSView with frame [\(frame)], and timer [\(isAnimating)]")
        return view
    }

    func updateNSView(_ nsView: MinimalCountdownView, context: Context) {
        nsView.needsLayout = true
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator {
        var timer: Timer?

        deinit {
            timer?.invalidate()
        }
    }
}
