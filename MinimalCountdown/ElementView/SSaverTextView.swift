//
//  SSaverTextView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import AppKit

final class SSaverTextView: NSTextField {
    init() {
        super.init(frame: NSZeroRect)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.drawsBackground = false
        self.isEditable = false
        self.isSelectable = false
        self.isBezeled = false
        self.alignment = .center
        self.textColor = Resources.mainTitleColor.withAlphaComponent(
            Resources.brightIsNormal
                ? .normalBright.texts
                : .dimBright.texts
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
