//
//  Resources.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import AppKit

enum Resources {
    // MARK: - Dictionaries

    enum ScreensaverState {
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

    static let titleColors: [NSColor] = [
        .white,
        .systemOrange,
        .systemIndigo,
        .systemYellow,
        .systemPurple,
        .systemRed,
        .systemPink,
        .systemMint,
        .systemBlue,
        .systemGreen,
        .cyan
    ]

    static let backgroundColors: [NSColor] = [
        .black,
        .white
    ]

    // MARK: - Preferencies

    static var mainTitleColor = Resources.titleColors[9]
    static var mainBackgroundColor = Resources.backgroundColors[0]
    static var titleString = "My BDay party in"
    static var brightIsNormal = false
    static var titleIsHidden = true
    static var showElements: Resources.ScreensaverState = .showAll
    static var goalDate = DateComponents(
        calendar: .current,
        year: 2024,
        month: 3,
        day: 26,
        hour: 2,
        minute: 30
    ).date
}
