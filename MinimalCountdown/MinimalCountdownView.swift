//
//  MinimalCountdownView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 21.02.2024.
//

import ScreenSaver

final class MinimalCountdownView: ScreenSaverView {
// MARK: - Private properties

    lazy var sheetController: ConfigureSheetController = ConfigureSheetController()
    private var screenSaverDefaults = ScreenSaverDefaults()

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
        super.init(frame: frame, isPreview: isPreview)
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        screenSaverDefaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier)!
        configureScene()
        animateOneFrame()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureScene()
    }

    // MARK: - Lifecycle

    override func draw(_ rect: NSRect) {
        configureScene()
        updateScene()
    }

    override func animateOneFrame() {
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
        screenSaverDefaults.synchronize()
        updateColor()
        configureElements()
        updateTitle()
        updateTargetDate()
    }

    func configureUI() {
        Resources.backgroundColors[screenSaverDefaults.backgroundColorIndex].setFill()
        NSBezierPath.fill(bounds)

        [vStack, elementsStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let elementWidth = round(bounds.width / .elementsWithSpaces)
        let digitsFont =  NSFont.systemFont(ofSize: elementWidth, weight: .ultraLight).monospacedNumbers
        let textsFont = NSFont.systemFont(ofSize: elementWidth / 5, weight: .ultraLight)

        messageLabel.font = textsFont
        elementsStack.spacing = round(bounds.width * .elementsSpacingRatio)

        [daysView, hoursView, minutesView, secondsView].enumerated().forEach { (index, view) in
            view.digitsLabel.font = digitsFont
            view.descriptionLabel.font = textsFont
            view.descriptionLabel.stringValue = Resources.elements[index].uppercased()
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
        daysView.digitsLabel.stringValue = screenSaverDefaults.targetDate.daysString
        hoursView.digitsLabel.stringValue = screenSaverDefaults.targetDate.hoursString
        minutesView.digitsLabel.stringValue = screenSaverDefaults.targetDate.minutesString
        secondsView.digitsLabel.stringValue = screenSaverDefaults.targetDate.secondsString
    }

    func updateColor() {
        [daysView, hoursView, minutesView, secondsView].forEach { view in
            view.digitsLabel.textColor = Resources.colors[screenSaverDefaults.colorIndex].withAlphaComponent(
                screenSaverDefaults.brightIsNormal
                ? .normalBright.digits
                : .dimBright.digits
            )
            view.descriptionLabel.textColor = Resources.colors[screenSaverDefaults.colorIndex].withAlphaComponent(
                screenSaverDefaults.brightIsNormal
                ? .normalBright.texts
                : .dimBright.texts
            )
        }
    }

    func updateTitle() {
        messageLabel.isHidden = screenSaverDefaults.messageIsHidden
        if !messageLabel.isHidden {
            let string = screenSaverDefaults.messageString.uppercased()
            let words = string.components(separatedBy: " ")
            let separator = string.count <= 20 ? "  " : "   "
            messageLabel.stringValue = words.joined(separator: separator)
            messageLabel.textColor = Resources.colors[screenSaverDefaults.colorIndex].withAlphaComponent(
                screenSaverDefaults.brightIsNormal
                ? .normalBright.texts
                : .dimBright.texts
            )
        }
    }

    func configureElements() {
        switch Resources.ScreensaverState(rawValue: screenSaverDefaults.showElementsIndex) {
        case .showDays:
            daysView.isHidden = false
            [hoursView, minutesView, secondsView].forEach{ $0.isHidden = true }
        case .showDaysHours:
            [daysView, hoursView].forEach{ $0.isHidden = false }
            [minutesView, secondsView].forEach{ $0.isHidden = true }
        case .showDaysHoursMinutes:
            [daysView, hoursView, minutesView].forEach{ $0.isHidden = false }
            [secondsView].forEach{ $0.isHidden = true }
        default:
            [daysView, hoursView, minutesView, secondsView].forEach{ $0.isHidden = false }
        }
    }
}
