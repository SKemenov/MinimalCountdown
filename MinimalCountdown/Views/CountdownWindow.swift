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

    @Environment(\.locale) private var locale

    var body: some View {
        let render = UIModel.RenderSettings(settings, locale: locale)
        let titleText = UIModel.formattedTitle(settings.title)

        GeometryReader { geo in
            let digitsSize = geo.size.width.digitsSize(isPreview: isPreview)

            ZStack {
                settings.theme.background.color
                    .ignoresSafeArea()

                VStack(spacing: .zero) {
                    TitleView(
                        element: .init(
                            text: titleText,
                            size: digitsSize * .titleToDigitsRatio,
                            color: render.textsColor,
                            weight: .thin
                        )
                    )
                    CountdownView(
                        now: now,
                        settings: settings,
                        render: render,
                        digitsSize: digitsSize,
                        spacing: geo.size.width * .elementsSpacingRatio
                    )
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        // The countdown is a clock/number — keep it left-to-right even under an RTL (Arabic) locale
        // (HIG: don't reverse the digits in a number). The settings window still mirrors normally.
        .environment(\.layoutDirection, .leftToRight)
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
