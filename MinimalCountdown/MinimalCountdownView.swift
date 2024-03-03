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

    private let titleLabel = SSaverTextView()

    private let elementsStack = NSStackView()

    private let vStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        return stack
    }()

    var mainTitleColorIndex = Resources.mainTitleColorIndex {
        didSet {
            configureScene()
        }
    }

    var titleString = Resources.titleString {
        didSet {
            configureScene()
        }
    }

    var brightIsNormal = Resources.brightIsNormal {
        didSet {
            configureScene()
        }
    }

    var titleIsHidden = Resources.titleIsHidden {
        didSet {
            configureScene()
        }
    }
    
    var goalDate = Resources.goalDate {
        didSet {
            configureScene()
        }
    }


    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        return sheetController.window
    }

    // Inits

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

    // NSView

    override func draw(_ rect: NSRect) {
        Resources.mainBackgroundColor.setFill()
        NSBezierPath.fill(bounds)
        configureScene()
    }


    // ScreenSaverView

    override func animateOneFrame() {
//        guard let goalDate = goalDate else { return }
        daysView.digitsLabel.stringValue = goalDate.daysString
        hoursView.digitsLabel.stringValue = goalDate.hoursString
        minutesView.digitsLabel.stringValue = goalDate.minutesString
        secondsView.digitsLabel.stringValue = goalDate.secondsString
    }
}

private extension MinimalCountdownView {
    func configureScene() {
        configureUI()
        configureElements()
        configureTitle()
        configureConstraints()
    }

    func configureUI() {
        let elementWidth = round(bounds.width / .elementsWithSpaces)
        let digitsFont =  NSFont.systemFont(ofSize: elementWidth, weight: .ultraLight).monospacedNumbers
        let textsFont = NSFont.systemFont(ofSize: elementWidth / 5, weight: .ultraLight)

        [vStack, elementsStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.font = textsFont
        titleLabel.textColor = Resources.titleColors[mainTitleColorIndex].withAlphaComponent(
            brightIsNormal
            ? .normalBright.texts
            : .dimBright.texts
        )
        elementsStack.spacing = round(bounds.width * .elementsSpacingRatio)

        [daysView, hoursView, minutesView, secondsView].enumerated().forEach { (index, element) in
            element.digitsLabel.font = digitsFont
            element.descriptionLabel.font = textsFont
            element.descriptionLabel.stringValue = Resources.elements[index].uppercased()
            element.digitsLabel.textColor = Resources.titleColors[mainTitleColorIndex].withAlphaComponent(
                brightIsNormal
                ? .normalBright.digits
                : .dimBright.digits
            )
            element.descriptionLabel.textColor = Resources.titleColors[mainTitleColorIndex].withAlphaComponent(
                brightIsNormal
                ? .normalBright.texts
                : .dimBright.texts
            )
            elementsStack.addArrangedSubview(element)
        }

        [titleLabel, elementsStack].forEach { vStack.addArrangedSubview($0) }
        addSubview(vStack)
    }

    func configureTitle() {
        titleLabel.stringValue = titleIsHidden ? "" : titleString.uppercased()
        titleLabel.isHidden = titleIsHidden
    }

    func configureElements() {
        switch Resources.showElements {
        case .showDays:
            daysView.isHidden = false
            [hoursView, minutesView, secondsView].forEach{ $0.isHidden = true }
        case .showDaysHours:
            [daysView, hoursView].forEach{ $0.isHidden = false }
            [minutesView, secondsView].forEach{ $0.isHidden = true }
        case .showDaysHoursMinutes:
            [daysView, hoursView, minutesView].forEach{ $0.isHidden = false }
            [secondsView].forEach{ $0.isHidden = true }
        case .showAll:
            [daysView, hoursView, minutesView, secondsView].forEach{ $0.isHidden = false }
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
