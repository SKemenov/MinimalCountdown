//
//  NSFont+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import AppKit

extension NSFont {
    // MARK: - Private enum

    var monospacedNumbers: NSFont {
        let features = [
            [NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
             NSFontDescriptor.FeatureKey.selectorIdentifier: kMonospacedNumbersSelector]
        ]
        let descriptor = fontDescriptor.addingAttributes([.featureSettings: features])
        return NSFont(descriptor: descriptor, size: pointSize) ?? self
    }
}
