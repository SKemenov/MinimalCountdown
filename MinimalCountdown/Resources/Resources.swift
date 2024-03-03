//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import AppKit

enum Resources {
    // MARK: - Dictionaries

    enum ScreensaverState: Int {
        case showDays
        case showDaysHours
        case showDaysHoursMinutes
        case showAll
    }

    static let elements = [
        "days",
        "hours",
        "minutes",
        "seconds"
    ]

    static let preferenceLabels = [
        "Message:",
        "Color:",
        "Date:",
        "Style:"
    ]

    static let colorNames = [
        "White",
        "Red",
        "Pink",
        "Orange",
        "Yellow",
        "Green",
        "Mint",
        "Cyan",
        "Blue",
        "Indigo",
        "Purple"
    ]

    static let colors: [NSColor] = [
        .white,
        .systemRed,
        .systemPink,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemMint,
        .cyan,
        .systemBlue,
        .systemIndigo,
        .systemPurple
    ]

    static let backgroundColors: [NSColor] = [
        .black,
        .white
    ]

    // MARK: - Preferencies

//    static var mainTitleColor = Resources.titleColors[mainTitleColorIndex]
//    static var mainBackgroundColor = Resources.backgroundColors[screenSaverDefaults.backgroundColorIndex]
//    static var mainTitleColorIndex = 9
//    static var titleString = "My BDay party in"
//    static var brightIsNormal = false
//    static var titleIsHidden = true
//    static var showElements: Resources.ScreensaverState = .showAll
//    static var targetDate = DateComponents(
//        calendar: .current,
//        year: 2024,
//        month: 3,
//        day: 26,
//        hour: 2,
//        minute: 30
//    ).date!
}
