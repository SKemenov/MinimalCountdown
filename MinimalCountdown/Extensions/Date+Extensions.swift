//
//  Date+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import Foundation

extension Date {
    // MARK: - Private enum

    private enum CountdownComponents {
        case day
        case hour
        case minute
        case second
    }

    // MARK: - Private method

    private func durationFromToday(in period: CountdownComponents) -> String {
        let total = Int(abs(self.timeIntervalSinceNow))
        // 86400 = 60s * 60m * 24h
        // 3600 = 60s * 60m
        let value: Int = switch period {
        case .day: total / 86_400
        case .hour: total % 86_400 / 3_600
        case .minute: total % 3_600 / 60
        case .second: total % 60
        }
        return String(format: "%02d", value)
    }

    // MARK: - Custom properties

    var daysString: String {
        self.durationFromToday(in: .day)
    }

    var hoursString: String {
        self.durationFromToday(in: .hour)
    }

    var minutesString: String {
        self.durationFromToday(in: .minute)
    }

    var secondsString: String {
        self.durationFromToday(in: .second)
    }
}
