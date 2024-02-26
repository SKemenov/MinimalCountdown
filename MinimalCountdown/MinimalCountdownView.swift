//
//  MinimalCountdownView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 21.02.2024.
//

import ScreenSaver

final class MinimalCountdownView: ScreenSaverView {

    convenience init() {
        self.init(frame: .zero, isPreview: false)
    }

    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        animateOneFrame()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    // NSView

    override func draw(_ rect: NSRect) {
    }


    // ScreenSaverView

    override func animateOneFrame() {
    }
}
