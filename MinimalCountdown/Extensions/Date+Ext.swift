//
//  Date+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

extension Date {
    // MARK: - Duration components relative to a reference `now` for target date
    func days(relativeTo now: Date) -> Int { self.duration(from: now, for: .days) }
    func hours(relativeTo now: Date) -> Int { self.duration(from: now, for: .hours) }
    func minutes(relativeTo now: Date) -> Int { self.duration(from: now, for: .minutes) }
    func seconds(relativeTo now: Date) -> Int { self.duration(from: now, for: .seconds) }

    // MARK: - DatePicker and date verification components
    func datesInBetween() -> ClosedRange<Date> { minDate ... maxDate }

    var minDate: Date { self.farAvailableDate(isFuture: false) }
    var maxDate: Date { self.farAvailableDate(isFuture: true) }
}

// MARK: - Private helpers
private extension Date {
    func duration(from now: Date, for element: AppearanceStyle) -> Int {
        // use ceil to fix double-zero issue
        let total = Int(abs(ceil(self.timeIntervalSince(now))))

        return switch element {
            case .days: total / .oneDay
            case .hours: total % .oneDay / .oneHour
            case .minutes: total % .oneHour / .oneMinute
            case .seconds: total % .oneMinute
        }
    }

    func farAvailableDate(isFuture: Bool) -> Self {
        Date(timeInterval: (isFuture ? .oneYearAndOneDay : -.oneYearAndOneDay), since: self)
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
