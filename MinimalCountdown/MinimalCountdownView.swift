//
//  MinimalCountdownView.swift
//  MinimalCountdown
//
//

import ScreenSaver

final class MinimalCountdownView: ScreenSaverView {
// MARK: - Private properties

    private let settingsManager: SettingsManager

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

    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        return sheetController.window
    }

    // MARK: - Inits

    convenience init() {
        self.init(frame: .zero, isPreview: false)
    }

    override init!(frame: NSRect, isPreview: Bool) {
        let bundleId: String = Bundle.main.bundleIdentifier ?? Resources.subSystem
        var stores: [LocalStore] = [FileStore()]
        if let defaultsStore = DefaultsStore(bundleIdentifier: bundleId) {
            stores.append(defaultsStore)
        }
        settingsManager = SettingsManager(stores: stores)

        super.init(frame: frame, isPreview: isPreview)
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        screenSaverDefaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier)!
        settingsManager.load()
        configureScene()
        animateOneFrame()
    }

    required init?(coder: NSCoder) {
        settingsManager = SettingsManager(stores: [FileStore()])
        super.init(coder: coder)
        settingsManager.load()
        configureScene()
    }

    // MARK: - Lifecycle

    override func draw(_ rect: NSRect) {
        configureBackground()
    }

    override func animateOneFrame() {
        needsDisplay = true
        updateScene()
    }
}

// MARK: - Private methods

private extension MinimalCountdownView {
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

    func configureBackground() {
        settingsManager.settings.backgroundColor.color.setFill()
        NSBezierPath.fill(bounds)
    }

    func configureUI() {
        [vStack, elementsStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let elementWidth = round(bounds.width / .elementsWithSpaces)
        let digitsFont =  NSFont.systemFont(ofSize: elementWidth, weight: .ultraLight).monospacedNumbers
        let textsFont = NSFont.systemFont(ofSize: elementWidth / 5, weight: .ultraLight)

        messageLabel.font = textsFont
        elementsStack.spacing = round(bounds.width * .elementsSpacingRatio)

        [daysView, hoursView, minutesView, secondsView].enumerated().forEach { (index, view) in
            view.digitsLabel.font = digitsFont
            view.descriptionLabel.font = textsFont
            view.descriptionLabel.stringValue = StyleElement.allCases[index].name.uppercased()
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
            view.digitsLabel.textColor = settingsManager.settings.color.color.withAlphaComponent(
                settingsManager.settings.isBrightNormal ? .normalBright.digits : .dimBright.digits
            )
            view.descriptionLabel.textColor = settingsManager.settings.color.color.withAlphaComponent(
                settingsManager.settings.isBrightNormal ? .normalBright.texts : .dimBright.texts
            )
        }
    }

    func updateTitle() {
        messageLabel.isHidden = settingsManager.settings.isMessageHidden
        if !messageLabel.isHidden {
            let string = settingsManager.settings.message.uppercased()
            let words = string.components(separatedBy: " ")
            let separator = string.count <= 20 ? "  " : "   "
            messageLabel.stringValue = words.joined(separator: separator)
            messageLabel.textColor = settingsManager.settings.color.color.withAlphaComponent(
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
}
