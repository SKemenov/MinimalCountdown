//
//  MinimalCountdownView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import ScreenSaver
import SwiftUI
import OSLog

final class MinimalCountdownView: ScreenSaverView {
    // MARK: - Private properties

    private let settingsManager: SettingsManager
    private let logger: Logger
    private let clock = CountdownClock()
    private var hostingView: NSHostingView<AnyView>?

    lazy var sheetController: ConfigureSheetController = ConfigureSheetController(settingsManager: settingsManager)

    // MARK: - Public properties

    override var hasConfigureSheet: Bool { true }

    override var configureSheet: NSWindow? { sheetController.window }

    // MARK: - Inits

    convenience init() {
        self.init(frame: .zero, isPreview: false)
    }

    override init!(frame: NSRect, isPreview: Bool) {
        logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        let message: String = isPreview ? "preview" : "screen saver"
        logger.log("Starting \(message, privacy: .public)")

        let file = FileLocalStore()
        let loader: SettingsLoader
        if let defaults = DefaultsLocalStore() {
            loader = MigratingLoader(saver: file, fallback: defaults)
        } else {
            logger.error("DefaultsLocalStore init failed, running without v1 fallback")
            loader = file
        }
        settingsManager = SettingsManager(saver: file, loader: loader)

        super.init(frame: frame, isPreview: isPreview)
        settingsManager.load()

        animationTimeInterval = 1.0
        configureHostingView()

        logger.log("Init complete for \(message, privacy: .public)")
    }

    required init?(coder: NSCoder) {
        logger = Logger(subsystem: AppSettings.subSystem, category: String(describing: Self.self))
        logger.critical("init(coder:) not implemented, exiting")
        fatalError("init(coder:) not implemented, exiting")
    }

    deinit {
        let message: String = isPreview ? "screen saver" : "preview"
        logger.log("Finished \(message, privacy: .public)")
    }

    // MARK: - Lifecycle

    override func animateOneFrame() {
        clock.now = Date()
    }
}

// MARK: - Private methods

private extension MinimalCountdownView {
    func configureHostingView() {
        let root = CountdownRootView(clock: clock, isPreview: isPreview)
            .environment(settingsManager)
        let hosting = NSHostingView(rootView: AnyView(root))
        hosting.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hosting)
        NSLayoutConstraint.activate([
            hosting.leadingAnchor.constraint(equalTo: leadingAnchor),
            hosting.trailingAnchor.constraint(equalTo: trailingAnchor),
            hosting.topAnchor.constraint(equalTo: topAnchor),
            hosting.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        hostingView = hosting
    }
}
