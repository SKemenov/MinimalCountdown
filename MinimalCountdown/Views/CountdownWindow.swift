//
//  CountdownWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct CountdownWindow: View {
    let now: Date
    let settings: SaverSettings
    var isPreview: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                settings.backgroundColor.color
                    .ignoresSafeArea()

                VStack(spacing: .zero) {
                    TitleView(
                        settings: settings,
                        textSize: geo.size.width.calculateSize(for: .title, isPreview: isPreview)
                    )
                    CountdownView(
                        now: now,
                        settings: settings,
                        windowWidth: geo.size.width,
                        isPreview: isPreview
                    )
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

#Preview("Default — 30 days out") {
    CountdownWindow(
        now: Date(),
        settings: .default
    )
    .frame(width: 500, height: 300)
}

#Preview("Default — for Preview") {
    CountdownWindow(
        now: Date(),
        settings: .default,
        isPreview: true
    )
    .frame(width: 500, height: 300)
}

#if DEBUG
#Preview("Days-only, dim, with message") {
    CountdownWindow(
        now: Date(),
        settings: SaverSettings.preview,
        isPreview: true
    )
    .frame(width: 500, height: 300)
}
#endif
