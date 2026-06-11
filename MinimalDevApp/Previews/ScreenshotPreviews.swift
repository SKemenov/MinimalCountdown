//
//  ScreenshotPreviews.swift
//  MinimalDevApp
//
//  Created by Sergey Kemenov
//

// README screenshot sources. Render each #Preview (Xcode canvas or RenderPreview),
// then crop the window title bar for the full-bleed countdown shots. Filenames map to
// vendors/mc-screenshot-*.png.
// Use Figma to generate final images:
// https://www.figma.com/design/7f6nLbnA7hD8v6c6GrlwWh/Screensaver-Mockups

#if DEBUG
import SwiftUI

// vendors/mc-screenshot-01s — classic, all units, default look
#Preview("Classic") {
    CountdownWindow(now: Date(), settings: .default, isPreview: true)
        .frame(width: 1024, height: 730)
}

// vendors/mc-screenshot-02s — days-only, cyan, with a message
#Preview("Cyan — days only") {
    CountdownWindow(
        now: Date(),
        settings: SaverSettings(
            appearance: .init(style: .days, isLabelHidden: false),
            schedule: .init(target: Date(timeIntervalSinceNow: 26 * 86400 + 3600)),
            theme: .init(accent: .cyan, background: .black, brightness: .high, effect: .none, effectColor: .cyan),
            typography: .init(weight: .bold, isRounded: false, numeralSystem: .automatic),
            language: .automatic,
            title: .init(text: "See you soon", isHidden: false)
        ),
        isPreview: true
    )
    .frame(width: 1024, height: 730)
}

// vendors/mc-screenshot-03s — amber glow with a title
#Preview("Amber glow") {
    CountdownWindow(
        now: Date(),
        settings: SaverSettings(
            appearance: .init(style: .seconds, isLabelHidden: false),
            schedule: .init(target: Date(timeIntervalSinceNow: 2 * 86400 + 16 * 3600 + 27 * 60 + 2)),
            theme: .init(accent: .yellow, background: .black, brightness: .high, effect: .glow, effectColor: .yellow),
            typography: .init(weight: .ultraLight, isRounded: false, numeralSystem: .automatic),
            language: .automatic,
            title: .init(text: "WWDC", isHidden: false)
        ),
        isPreview: true
    )
    .frame(width: 1024, height: 730)
}

// vendors/mc-screenshot-04s — backlight effect, bold rounded digits, pink
#Preview("Pink — backlight") {
    CountdownWindow(
        now: Date(),
        settings: SaverSettings(
            appearance: .init(style: .seconds, isLabelHidden: false),
            schedule: .init(target: Date(timeIntervalSinceNow: 7 * 86400 + 3600)),
            theme: .init(accent: .pink, background: .black, brightness: .high, effect: .backlight, effectColor: .pink),
            typography: .init(weight: .bold, isRounded: true, numeralSystem: .automatic),
            language: .automatic,
            title: .init(text: "", isHidden: true)
        ),
        isPreview: false
    )
    .frame(width: 1024, height: 730)
}
#endif
