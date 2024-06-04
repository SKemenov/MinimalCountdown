//
//  SSaverTextView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
