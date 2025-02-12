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
    /// Total seconds in an year and one day: 31 622 400.0 = 60.0 * 60 * 24 * (365 + 1)
    static let oneYearAndOneDay = 60.0 * 60 * 24 * (365 + 1)

    // MARK: - Color properties
    /// CGFloat = (digits: 1.0, texts: 0.7)
    static let normalBright = (digits: 1.0, texts: 0.7)
    /// CGFloat = (digits: 0.8, texts: 0.5)
    static let dimBright = (digits: 0.8, texts: 0.5)
}
