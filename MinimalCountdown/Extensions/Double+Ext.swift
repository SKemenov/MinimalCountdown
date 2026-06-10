//
//  Double+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

extension Double {
    // MARK: - Duration properties
    /// Total seconds in one day: 86 400.0 = 60s * 60m * 24h
    static let oneDay = 60.0 * 60 * 24
    /// Max selectable countdown range from today: 999 days (keeps the days tile at 3 digits).
    static let rangeLimit = oneDay * 999
}
