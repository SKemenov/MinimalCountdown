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

    let messageLabel = NSTextField(labelWithString: Resources.preferences[0])
    let colorLabel = NSTextField(labelWithString: Resources.preferences[1])
    let dateLabel = NSTextField(labelWithString: Resources.preferences[2])
    let styleLabel = NSTextField(labelWithString: Resources.preferences[3])
    let daysLabel = NSTextField(labelWithString: Resources.elements[0].capitalized)
    let hoursLabel = NSTextField(labelWithString: Resources.elements[1].capitalized)
    let minutesLabel = NSTextField(labelWithString: Resources.elements[2].capitalized)
    let secondsLabel = NSTextField(labelWithString: Resources.elements[3].capitalized)

    let okButton = NSButton()
    let cancelButton = NSButton()

    // MARK: - User input element's properties

    var messageField = NSTextField()
    var messageCheckbox = NSButton()
    var dimCheckbox = NSButton()
    var colorPopupButton = NSPopUpButton()
    var datePicker = NSDatePicker()
    var styleSlider = NSSlider()

    // MARK: - Store properties
    // MARK: - Private properties
    private var screenSaverDefaults = ScreenSaverDefaults()


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
        colorPopupButton.selectItem(at: screenSaverDefaults.colorIndex)
        styleSlider.integerValue = screenSaverDefaults.showElementsIndex
        messageField.stringValue = screenSaverDefaults.messageString
        messageCheckbox.state = !screenSaverDefaults.messageIsHidden ? .on : .off
        dimCheckbox.state = !screenSaverDefaults.brightIsNormal ? .on : .off
        datePicker.dateValue = screenSaverDefaults.targetDate
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
        okButton.title = "OK"
        okButton.keyEquivalent = "\r"

        cancelButton.title = "Cancel"

        styleSlider.trackFillColor = .blue
        styleSlider.minValue = 0
        styleSlider.maxValue = 3
        styleSlider.allowsTickMarkValuesOnly = true
        styleSlider.numberOfTickMarks = 4
        styleSlider.tickMarkPosition = .below

        messageField.isEditable = true
        messageField.placeholderString = "Input your message here"
        messageField.stringValue = messageFieldValue

        [messageCheckbox, dimCheckbox].forEach { checkbox in
            checkbox.bezelStyle = .push
            checkbox.setButtonType(.switch)
        }
        messageCheckbox.state = messageCheckboxValue ? .on : .off
        messageCheckbox.title = "Show the message"

        dimCheckbox.state = dimCheckboxValue ? .on : .off
        dimCheckbox.title = "Dim accent color"

        colorPopupButton.removeAllItems()
        colorPopupButton.addItems(withTitles: Resources.colorSet)
        colorPopupButton.selectItem(at: colorPopupButtonIndex)

        datePicker.dateValue = datePickerValue
        datePicker.datePickerStyle = .textField
        datePicker.presentsCalendarOverlay = true
        datePicker.datePickerMode = .single
        datePicker.minDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * -1)
        datePicker.maxDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
        datePicker.calendar = .current

        okButton.action = #selector(okButtonClicked)
        cancelButton.action = #selector(cancelButtonClicked)
        styleSlider.action = #selector(styleSliderClicked(_:))
        messageField.action = #selector(messageFieldFilled(_:))
        messageCheckbox.action = #selector(messageCheckboxClicked(_:))
        dimCheckbox.action = #selector(dimCheckboxClicked(_:))
        colorPopupButton.action = #selector(colorPopupButtonClicked(_:))
        datePicker.action = #selector(DatePickerClicked(_:))
    }

    func configureConstraints() {
        let space: CGFloat = 16
        let smallSpace: CGFloat = 4
        let leading: CGFloat = 24

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: leading),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            messageLabel.widthAnchor.constraint(equalToConstant: 72),

            messageField.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            messageField.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: space),
            messageField.widthAnchor.constraint(equalToConstant: 256),

            messageCheckbox.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: space),
            messageCheckbox.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: space),
            messageCheckbox.widthAnchor.constraint(equalToConstant: 168),

            colorLabel.topAnchor.constraint(equalTo: messageCheckbox.bottomAnchor, constant: space),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            colorLabel.widthAnchor.constraint(equalToConstant: 72),

            colorPopupButton.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
            colorPopupButton.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: space),
            //            colorPopupButton.widthAnchor.constraint(equalToConstant: 168),

            dimCheckbox.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: space),
            dimCheckbox.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: space),
            dimCheckbox.widthAnchor.constraint(equalToConstant: 168),

            dateLabel.topAnchor.constraint(equalTo: dimCheckbox.bottomAnchor, constant: space),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            dateLabel.widthAnchor.constraint(equalToConstant: 72),

            datePicker.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: space),

            styleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: space),
            styleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            styleLabel.widthAnchor.constraint(equalToConstant: 72),

            styleSlider.centerYAnchor.constraint(equalTo: styleLabel.centerYAnchor),
            styleSlider.leadingAnchor.constraint(equalTo: styleLabel.trailingAnchor, constant: space),
            styleSlider.widthAnchor.constraint(equalToConstant: 256),

            daysLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: smallSpace),
            daysLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor, constant: -8),

            hoursLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: smallSpace),
            hoursLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor, constant: 70),

            minutesLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: smallSpace),
            minutesLabel.leadingAnchor.constraint(equalTo: styleSlider.leadingAnchor, constant: 144),

            secondsLabel.topAnchor.constraint(equalTo: styleSlider.bottomAnchor, constant: smallSpace),
            secondsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leading),

            okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -leading),
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leading),
            okButton.widthAnchor.constraint(equalToConstant: 72),
            okButton.heightAnchor.constraint(equalToConstant: 24),

            cancelButton.bottomAnchor.constraint(equalTo: okButton.bottomAnchor, constant: 0),
            cancelButton.trailingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: -space),
            cancelButton.widthAnchor.constraint(equalToConstant: 72),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }

    @objc func colorPopupButtonClicked(_ sender: NSPopUpButton) {
        colorPopupButtonIndex = sender.indexOfSelectedItem
    }

    @objc func messageFieldFilled(_ sender: NSTextField) {
//        messageFieldValue = sender.stringValue
    }

    @objc func messageCheckboxClicked(_ sender: NSButton) {
        messageCheckboxValue = sender.state.rawValue == 1 ? true : false
    }

    @objc func dimCheckboxClicked(_ sender: NSButton) {
        dimCheckboxValue = sender.state.rawValue == 1 ? true : false
    }

    @objc func DatePickerClicked(_ sender: NSDatePicker) {
        datePickerValue = sender.dateValue
    }

    @objc func styleSliderClicked(_ sender: NSSlider) {
//        print(#function, sender.tickMarkPosition)
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
        saveData()
        closeSheet()
    }

    @objc func cancelButtonClicked() {
        closeSheet()
    }
}
