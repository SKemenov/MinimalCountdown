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
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents(
            [.day, .hour, .minute, .second],
            from: currentDate,
            to: self
        )
        var value = ""

        switch period {
        case .day: value = String(format: "%02d", abs(components.day ?? 0))
        case .hour: value = String(format: "%02d", abs(components.hour ?? 0))
        case .minute: value = String(format: "%02d", abs(components.minute ?? 0))
        case .second: value = String(format: "%02d", abs(components.second ?? 0))
        }
        return value
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
