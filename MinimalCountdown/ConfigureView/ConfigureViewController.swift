//
//  ConfigureViewController.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 26.02.2024.
//

import ScreenSaver
import AppKit

final class ConfigureViewController: NSViewController {
    // MARK: - UI element's properties

    private let messageLabel = NSTextField(labelWithString: Resources.preferenceLabels[0])
    private let colorLabel = NSTextField(labelWithString: Resources.preferenceLabels[1])
    private let dateLabel = NSTextField(labelWithString: Resources.preferenceLabels[2])
    private let styleLabel = NSTextField(labelWithString: Resources.preferenceLabels[3])
    private let daysLabel = NSTextField(labelWithString: Resources.elements[0].capitalized)
    private let hoursLabel = NSTextField(labelWithString: Resources.elements[1].capitalized)
    private let minutesLabel = NSTextField(labelWithString: Resources.elements[2].capitalized)
    private let secondsLabel = NSTextField(labelWithString: Resources.elements[3].capitalized)

    private let okButton = NSButton()
    private let cancelButton = NSButton()

    // MARK: - User input element's properties

    private var messageField = NSTextField()
    private var messageCheckbox = NSButton()
    private var dimCheckbox = NSButton()
    private var colorPopupButton = NSPopUpButton()
    private var datePicker = NSDatePicker()
    private var styleSlider = NSSlider()

    // MARK: - Private properties
    
    private var screenSaverDefaults = ScreenSaverDefaults()

    // MARK: - Lifecycle

    override func loadView() {
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        screenSaverDefaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier)!
        view = NSView(frame: NSMakeRect(0.0, 0.0, 390, 256))
        configureUI()
        configureConstraints()
    }

    override func viewWillAppear() {
        configureValues()
    }
}

private extension ConfigureViewController {
    func configureValues() {
        colorPopupButton.removeAllItems()
        colorPopupButton.addItems(withTitles: Resources.colorNames)

        colorPopupButton.selectItem(at: screenSaverDefaults.colorIndex)
        styleSlider.integerValue = screenSaverDefaults.showElementsIndex
        messageField.stringValue = screenSaverDefaults.messageString
        messageCheckbox.state = !screenSaverDefaults.messageIsHidden ? .on : .off
        dimCheckbox.state = !screenSaverDefaults.brightIsNormal ? .on : .off
        datePicker.dateValue = screenSaverDefaults.targetDate

        datePicker.minDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * -1)
        datePicker.maxDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
    }

    func configureUI() {
        [
            messageLabel, colorLabel, dateLabel, styleLabel, daysLabel, hoursLabel, minutesLabel, secondsLabel,
            messageField, messageCheckbox, colorPopupButton, dimCheckbox, datePicker, styleSlider,
            okButton, cancelButton
        ].forEach { element in
            element.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(element)
        }

        [messageLabel, colorLabel, dateLabel, styleLabel, secondsLabel].forEach { $0.alignment = .right }

        [okButton, cancelButton].forEach { button in
            button.bezelStyle = .push
            button.setButtonType(.momentaryPushIn)
        }

        [messageCheckbox, dimCheckbox].forEach { checkbox in
            checkbox.bezelStyle = .push
            checkbox.setButtonType(.switch)
        }
        okButton.title = "OK"
        okButton.keyEquivalent = "\r"
        okButton.action = #selector(okButtonClicked)

        cancelButton.title = "Cancel"
        cancelButton.action = #selector(cancelButtonClicked)

        styleSlider.minValue = 0
        styleSlider.maxValue = 3
        styleSlider.allowsTickMarkValuesOnly = true
        styleSlider.numberOfTickMarks = 4
        styleSlider.tickMarkPosition = .below

        messageField.isEditable = true
        messageField.isSelectable = true
        messageField.becomeFirstResponder()
        messageField.placeholderString = "Input your message here"
        messageCheckbox.title = "Show the message"
        dimCheckbox.title = "Dim the accent color"

        datePicker.datePickerStyle = .textField
        datePicker.presentsCalendarOverlay = true
        datePicker.datePickerMode = .single
        datePicker.calendar = .current
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .leading),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leading),
            messageLabel.widthAnchor.constraint(equalToConstant: .labelWidth),

            messageField.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            messageField.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: .smallLeading),
            messageField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.leading),

            messageCheckbox.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: .space),
            messageCheckbox.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: .smallLeading),

            colorLabel.topAnchor.constraint(equalTo: messageCheckbox.bottomAnchor, constant: .space),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leading),
            colorLabel.widthAnchor.constraint(equalToConstant: .labelWidth),

            colorPopupButton.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
            colorPopupButton.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: .smallLeading),

            dimCheckbox.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: .space),
            dimCheckbox.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: .smallLeading),

            dateLabel.topAnchor.constraint(equalTo: dimCheckbox.bottomAnchor, constant: .space),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leading),
            dateLabel.widthAnchor.constraint(equalToConstant: .labelWidth),

            datePicker.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: .smallLeading),

            styleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .space),
            styleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leading),
            styleLabel.widthAnchor.constraint(equalToConstant: .labelWidth),

            styleSlider.centerYAnchor.constraint(equalTo: styleLabel.centerYAnchor),
            styleSlider.leadingAnchor.constraint(equalTo: styleLabel.trailingAnchor, constant: .smallLeading),
            styleSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.leading),

            daysLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: .smallSpace),
            daysLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor),

            hoursLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: .smallSpace),
            hoursLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor, constant: 80),

            minutesLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: .smallSpace),
            minutesLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor, constant: 165),

            secondsLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: .smallSpace),
            secondsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.leading),

            okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.leading),
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.leading),
            okButton.widthAnchor.constraint(equalToConstant: .buttonWidth),
            okButton.heightAnchor.constraint(equalToConstant: .buttonHeight),

            cancelButton.bottomAnchor.constraint(equalTo: okButton.bottomAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: -.space),
            cancelButton.widthAnchor.constraint(equalToConstant: .buttonWidth),
            cancelButton.heightAnchor.constraint(equalToConstant: .buttonHeight),
        ])
    }

    func saveData() {
        screenSaverDefaults.brightIsNormal = !(dimCheckbox.state.rawValue == 1 ? true : false)
        screenSaverDefaults.messageIsHidden = !(messageCheckbox.state.rawValue == 1 ? true : false)
        screenSaverDefaults.colorIndex = colorPopupButton.indexOfSelectedItem
        screenSaverDefaults.showElementsIndex = styleSlider.integerValue
        screenSaverDefaults.messageString = messageField.stringValue
        screenSaverDefaults.targetDate = datePicker.dateValue
        screenSaverDefaults.synchronize()
    }

    func closeSheet() {
        view.window?.sheetParent?.endSheet(view.window!)
    }

    @objc func okButtonClicked() {
        messageField.resignFirstResponder()
        saveData()
        closeSheet()
    }

    @objc func cancelButtonClicked() {
        closeSheet()
    }
}
