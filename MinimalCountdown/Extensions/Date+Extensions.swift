//
//  Date+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

// MARK: - Custom properties
extension Date {
    var daysString: String { self.durationFromToday(in: .days) }
    var hoursString: String { self.durationFromToday(in: .hours) }
    var minutesString: String { self.durationFromToday(in: .minutes) }
    var secondsString: String { self.durationFromToday(in: .seconds) }
}

// MARK: - Private properties
private extension Date {
    func durationFromToday(in period: StyleElement) -> String {
        // use ceil to fix double-zero issue
        let total = Int(abs(ceil(self.timeIntervalSinceNow)))
        // 86_400 = 60s * 60m * 24h
        // 3_600 = 60s * 60m
        let value: Int = switch period {
        case .days:    total / 86_400
        case .hours:   total % 86_400 / 3_600
        case .minutes: total % 3_600 / 60
        case .seconds: total % 60
        }
        return String(format: "%02d", value)
    }
}
