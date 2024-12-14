//
//  MinimalCountdownView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import ScreenSaver
import OSLog

final class MinimalCountdownView: ScreenSaverView {
    // MARK: - Private properties

    private let settingsManager: SettingsManager
    private let logger: Logger

    lazy var sheetController: ConfigureSheetController = ConfigureSheetController(settingsManager: settingsManager)

    private let daysView = ElementView()
    private let hoursView = ElementView()
    private let minutesView = ElementView()
    private let secondsView = ElementView()

    private let messageLabel = SSaverTextView()

    private let elementsStack = NSStackView()

    private let vStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        return stack
    }()

    // MARK: - Public properties

    override var hasConfigureSheet: Bool { true }

    override var configureSheet: NSWindow? { sheetController.window }

    // MARK: - Inits

    convenience init() {
        self.init(frame: .zero, isPreview: false)
    }

    override init!(frame: NSRect, isPreview: Bool) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        let message: String = isPreview ? "preview" : "screen saver"
        logger.log("Starting \(message, privacy: .public)")

        var stores: [LocalStore] = []
        if let fileStore = FileStore() {
            stores.append(fileStore)
        } else {
            logger.error("FileStore init failed, running without settings file")
        }
        if let defaultsStore = DefaultsStore() {
            stores.append(defaultsStore)
        } else {
            logger.error("DefaultsStore init failed, running without Defaults")
        }
        settingsManager = SettingsManager(stores: stores)

        super.init(frame: frame, isPreview: isPreview)
        settingsManager.load()

        animationTimeInterval = 1.0
        configureScene()
        animateOneFrame()
//        registerForScreensaverNotifications()

        logger.log("Init complete for \(message, privacy: .public)")
    }

    required init?(coder: NSCoder) {
        logger = Logger(subsystem: Resources.subSystem, category: String(describing: Self.self))
        logger.critical("init(coder:) not implemented, exiting")
        fatalError("init(coder:) not implemented, exiting")
    }

    deinit {
        let message: String = isPreview ? "screen saver" : "preview"
        logger.log("Finished \(message, privacy: .public)")
    }

    // MARK: - Lifecycle

//    override func startAnimation() {
//        super.startAnimation()
//        let message: String = isPreview ? "Screen saver" : "Preview"
//        logger.log("\(message, privacy: .public) \(#function, privacy: .public)")
//    }
//
//    override func stopAnimation() {
//        if !isPreview {
//            super.stopAnimation()
//            logger.log("Preview \(#function, privacy: .public)")
//        }
//    }
//
//    override func draw(_ rect: NSRect) {
//        configureBackground()
//    }

    override func animateOneFrame() {
        needsDisplay = true
        updateScene()
    }
}

// MARK: - Private methods

private extension MinimalCountdownView {
//    func registerForScreensaverNotifications() {
//        DistributedNotificationCenter.default().addObserver(
//            self,
//            selector: #selector(MinimalCountdownView.stopAnimation),
//            name: NSNotification.Name("com.apple.screensaver.willstop"),
//            object: nil
//        )
//    }

    func configureScene() {
        configureUI()
        configureConstraints()
    }

    func updateScene() {
        updateColor()
        configureElements()
        updateTitle()
        updateTargetDate()
    }

//    func configureBackground() {
//        settingsManager.settings.backgroundColor.nsColor.setFill()
//        NSBezierPath.fill(bounds)
//    }

    func configureUI() {
        [vStack, elementsStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let elementWidth = round(bounds.width / (isPreview ? (.elementsWithSpaces - 1) : .elementsWithSpaces))
        let digitsFont = NSFont.systemFont(ofSize: elementWidth, weight: .ultraLight).monospacedNumbers
        let textsFont = NSFont.systemFont(ofSize: elementWidth / 5, weight: .ultraLight)
        // need to check on other than Tahoe system
//        let elementWidth = round(bounds.width / (isPreview ? (.elementsWithSpaces - 3) : .elementsWithSpaces))
//        let digitsFont = NSFont.systemFont(
//            ofSize: elementWidth,
//            weight: isPreview ? .regular : .ultraLight
//        ).monospacedNumbers
//        let textsFont = NSFont.systemFont(
//            ofSize: elementWidth / (isPreview ? 3 : 5),
//            weight: isPreview ? .regular : .ultraLight
//        )

        messageLabel.font = textsFont
        elementsStack.spacing = round(bounds.width * .elementsSpacingRatio)

        [daysView, hoursView, minutesView, secondsView].enumerated().forEach { (index, view) in
            view.digitsLabel.font = digitsFont
            view.descriptionLabel.font = textsFont
            view.descriptionLabel.stringValue = StyleElement.allCases[index].label.uppercased()
            elementsStack.addArrangedSubview(view)
        }

        [messageLabel, elementsStack].forEach { vStack.addArrangedSubview($0) }
        addSubview(vStack)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func updateTargetDate() {
        daysView.digitsLabel.stringValue = settingsManager.settings.targetDate.daysString
        hoursView.digitsLabel.stringValue = settingsManager.settings.targetDate.hoursString
        minutesView.digitsLabel.stringValue = settingsManager.settings.targetDate.minutesString
        secondsView.digitsLabel.stringValue = settingsManager.settings.targetDate.secondsString
    }

    func updateColor() {
        [daysView, hoursView, minutesView, secondsView].forEach { view in
            view.digitsLabel.textColor = settingsManager.settings.color.nsColor.withAlphaComponent(
                settingsManager.settings.isBrightNormal ? .normalBright.digits : .dimBright.digits
            )
            view.descriptionLabel.textColor = settingsManager.settings.color.nsColor.withAlphaComponent(
                settingsManager.settings.isBrightNormal ? .normalBright.texts : .dimBright.texts
            )
        }
    }

    func updateTitle() {
        messageLabel.isHidden = settingsManager.settings.isMessageHidden
        if !messageLabel.isHidden {
            let string = settingsManager.settings.message.uppercased()
            let words = string.components(separatedBy: " ")
            let separator = string.count <= 30 ? "  " : "   "
            messageLabel.stringValue = words.joined(separator: separator)
            messageLabel.textColor = settingsManager.settings.color.nsColor.withAlphaComponent(
                settingsManager.settings.isBrightNormal ? .normalBright.texts : .dimBright.texts
            )
        }
    }

    func configureElements() {
        switch settingsManager.settings.style {
        case .days:
            daysView.isHidden = false
            [hoursView, minutesView, secondsView].forEach { $0.isHidden = true }
        case .hours:
            [daysView, hoursView].forEach { $0.isHidden = false }
            [minutesView, secondsView].forEach { $0.isHidden = true }
        case .minutes:
            [daysView, hoursView, minutesView].forEach { $0.isHidden = false }
            secondsView.isHidden = true
        case .seconds:
            [daysView, hoursView, minutesView, secondsView].forEach { $0.isHidden = false }
        }
    }
//    check on non-Tahoe platforms
//    func configureElements() {
//        if isPreview {
//            [daysView, hoursView].forEach { $0.isHidden = true }
//            [minutesView, secondsView].forEach { $0.isHidden = false }
//        } else {
//            switch settingsManager.settings.style {
//            case .days:
//                daysView.isHidden = false
//                [hoursView, minutesView, secondsView].forEach { $0.isHidden = true }
//            case .hours:
//                [daysView, hoursView].forEach { $0.isHidden = false }
//                [minutesView, secondsView].forEach { $0.isHidden = true }
//            case .minutes:
//                [daysView, hoursView, minutesView].forEach { $0.isHidden = false }
//                secondsView.isHidden = true
//            case .seconds:
//                [daysView, hoursView, minutesView, secondsView].forEach { $0.isHidden = false }
//            }
//        }
//    }
}
