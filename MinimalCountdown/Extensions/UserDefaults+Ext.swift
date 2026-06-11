//
//  UserDefaults+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import ScreenSaver

extension ScreenSaverDefaults {
    // MARK: - Private enum

    private enum ScreenSaverDefaultsKeys: String {
        case messageIsHidden
        case brightIsNormal
        case colorIndex
        case backgroundColorIndex
        case showElementsIndex
        case messageString
        case targetDate
    }

    // MARK: - Read-only properties (legacy v1 keys; DefaultsLocalStore is load-only)

    var messageIsHidden: Bool {
        bool(forKey: ScreenSaverDefaultsKeys.messageIsHidden.rawValue)
    }
    var brightIsNormal: Bool {
        bool(forKey: ScreenSaverDefaultsKeys.brightIsNormal.rawValue)
    }
    var colorIndex: Int {
        integer(forKey: ScreenSaverDefaultsKeys.colorIndex.rawValue)
    }
    var backgroundColorIndex: Int {
        integer(forKey: ScreenSaverDefaultsKeys.backgroundColorIndex.rawValue)
    }
    var showElementsIndex: Int {
        integer(forKey: ScreenSaverDefaultsKeys.showElementsIndex.rawValue)
    }
    var messageString: String {
        string(forKey: ScreenSaverDefaultsKeys.messageString.rawValue) ?? ""
    }
    var targetDate: Date {
        Date(timeIntervalSince1970: double(forKey: ScreenSaverDefaultsKeys.targetDate.rawValue))
    }
}
