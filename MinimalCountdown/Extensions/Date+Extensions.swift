//
//  Date+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

extension Date {
    // MARK: - Duration components relative to a reference `now` for target date
    func daysString(relativeTo now: Date) -> String { self.duration(from: now, for: .days) }
    func hoursString(relativeTo now: Date) -> String { self.duration(from: now, for: .hours) }
    func minutesString(relativeTo now: Date) -> String { self.duration(from: now, for: .minutes) }
    func secondsString(relativeTo now: Date) -> String { self.duration(from: now, for: .seconds) }
}

// MARK: - Private helpers
private extension Date {
    func duration(from now: Date, for element: StyleElement) -> String {
        // use ceil to fix double-zero issue
        let total = Int(abs(ceil(self.timeIntervalSince(now))))

        let elementDuration: Int = switch element {
            case .days: total / .oneDay
            case .hours: total % .oneDay / .oneHour
            case .minutes: total % .oneHour / .oneMinute
            case .seconds: total % .oneMinute
        }
        return String(format: "%02d", elementDuration)
    }
}

private extension Int {
    /// Total seconds in one day: 86 400 = 60s * 60m * 24h
    static let oneDay = 60 * 60 * 24
    /// Total seconds in one hour: 3 600 = 60s * 60m
    static let oneHour = 60 * 60
    /// Total seconds in one minute: 60
    static let oneMinute = 60
}
