//
//  CGFloat+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

extension CGFloat {
    // MARK: - Design tokens
    enum Spacing {
        /// CGFloat = 2
        static let xxSmall: CGFloat = 2
        /// CGFloat = 4
        static let xSmall: CGFloat = 4
        /// CGFloat = 6
        static let small: CGFloat = 6
        /// CGFloat = 8
        static let medium: CGFloat = 8
        /// CGFloat = 12
        static let large: CGFloat = 12
        /// CGFloat = 16
        static let xLarge: CGFloat = 16
        
    }

    enum Border {
        /// CGFloat = 1
        static let small: CGFloat = 1
        /// CGFloat = 3
        static let medium: CGFloat = 3
    }

    enum Sizes {
        /// CGFloat = 512 for Settings window width
        static let settingsWidth: CGFloat = 512
        /// CGFloat = 72 for each appearance width
        static let appearanceWidth: CGFloat = 72
        /// CGFloat = 40 for each appearance height
        static let appearanceHeight: CGFloat = 40
        /// CGFloat = 20 for color selector's icons
        static let colorSelector: CGFloat = 20
    }

    // MARK: - View elements helpers
    enum Elements { case digits, labels, title, spacing }

    static func calcElements(_ isPreview: Bool) -> Self {
        .elementsWithSpaces - (isPreview ? 1 : 0)
    }

    func calculateSize(for element: Elements, isPreview: Bool) -> CGFloat {
        switch element {
            case .digits: self / .calcElements(isPreview)
            case .labels: self / .calcElements(isPreview) / 5
            case .title: self / .calcElements(isPreview) / 4
            case .spacing: self * .elementsSpacingRatio
        }
    }
}

// MARK: - Private properties
private extension CGFloat {
    /// CGFloat = 7: Max 4 elements, add one more for each side and one more again for all spacing between elements
    static let elementsWithSpaces: CGFloat = 7 // 4 + 2 + 1
    /// CGFloat = 0.04
    static let elementsSpacingRatio: CGFloat = 0.04
}
