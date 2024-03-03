//
//  UserDefaults+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 29.02.2024.
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

    // MARK: - Custom properties
    
    var messageIsHidden: Bool {
        get {
            bool(forKey: ScreenSaverDefaultsKeys.messageIsHidden.rawValue)
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.messageIsHidden.rawValue)
        }
    }

    var brightIsNormal: Bool {
        get {
            bool(forKey: ScreenSaverDefaultsKeys.brightIsNormal.rawValue)
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.brightIsNormal.rawValue)
        }
    }

    var colorIndex: Int {
        get {
            integer(forKey: ScreenSaverDefaultsKeys.colorIndex.rawValue)
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.colorIndex.rawValue)
        }
    }

    var backgroundColorIndex: Int {
        get {
            integer(forKey: ScreenSaverDefaultsKeys.backgroundColorIndex.rawValue)
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.backgroundColorIndex.rawValue)
        }
    }

    var showElementsIndex: Int {
        get {
            integer(forKey: ScreenSaverDefaultsKeys.showElementsIndex.rawValue)
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.showElementsIndex.rawValue)
        }
    }

    var messageString: String {
        get {
            string(forKey: ScreenSaverDefaultsKeys.messageString.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: ScreenSaverDefaultsKeys.messageString.rawValue)
        }
    }

    var targetDate: Date {
        get {
            Date(timeIntervalSince1970: double(forKey: ScreenSaverDefaultsKeys.targetDate.rawValue))
        }
        set {
            setValue(newValue.timeIntervalSince1970, forKey: ScreenSaverDefaultsKeys.targetDate.rawValue)
        }
    }
}
