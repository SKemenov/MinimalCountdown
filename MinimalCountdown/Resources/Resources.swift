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
}
