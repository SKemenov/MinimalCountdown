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
        /// CGFloat = 36 for each appearance tile height
        static let appearanceHeight: CGFloat = 36
        /// CGFloat = 20 for color selector's icons
        static let colorSelector: CGFloat = 20
    }

    // MARK: - View elements helpers

    /// Baseline digits font size derived from the window width. Subtracts one element slot in preview thumbnails
    /// so the small canvas reads with a slightly larger relative font.
    func digitsSize(isPreview: Bool) -> CGFloat {
        self / (.elementsWithSpaces - (isPreview ? 1 : 0))
    }

    /// Label text size relative to the digits baseline. CGFloat = 1.0 / 5.0
    static let labelsToDigitsRatio: CGFloat = 1.0 / 5.0
   /// Non Latin label text size relative to the digits baseline. CGFloat = 1.0 / 3.8
    static let nonLatinLabelsToDigitsRatio: CGFloat = 1.0 / 3.8
    /// Title text size relative to the digits baseline. CGFloat = 1.0 / 4.0
    static let titleToDigitsRatio: CGFloat = 1.0 / 4.0
    /// Inter-element spacing as a fraction of window width. CGFloat = 0.04
    static let elementsSpacingRatio: CGFloat = 0.04

    // MARK: - Effect radii (Phase 9) — fractions of the digit font size

    /// Glow + backlight — tight core layer, stacked for density. CGFloat = 0.015
    static let glowCoreRatio: CGFloat = 0.015
    /// Glow + backlight — wider spread layer. CGFloat = 0.06
    static let glowSpreadRatio: CGFloat = 0.06
    /// Blur effect — blur radius applied to the digits. CGFloat = 0.03
    static let blurRatio: CGFloat = 0.03
    /// Inner glow — layer radius. CGFloat = 0.01
    static let innerGlowRatio: CGFloat = 0.01
    /// Inner glow — wider spread layer. CGFloat = 0.02
    static let innerGlowSpreadRatio: CGFloat = 0.02
}

// MARK: - Private properties
private extension CGFloat {
    /// CGFloat = 7: Max 4 elements, add one more for each side and one more again for all spacing between elements
    static let elementsWithSpaces: CGFloat = 7 // 4 + 2 + 1
}
