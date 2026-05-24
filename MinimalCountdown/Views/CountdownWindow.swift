//
//  CountdownWindow.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct CountdownWindow: View {
    let now: Date
    var settings: SaverSettings
    var locale: Locale = .current
    var isPreview: Bool = false
    @State private var render: UIModel.RenderSettings?
    @State private var titleText = String()

    var body: some View {
        GeometryReader { geo in
            settings.theme.background.color
                .ignoresSafeArea()

            if let render {
                VStack(spacing: .zero) {
                    showTitle(width: geo.size.width, with: render)
                    showCountdown(width: geo.size.width, with: render)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .task(id: settings, applySettings)
    }
}

private extension CountdownWindow {
    func applySettings() {
        render = UIModel.RenderSettings(settings, locale: locale)
        titleText = UIModel.formattedTitle(settings.title)
    }

    func showTitle(width: CGFloat, with render: UIModel.RenderSettings) -> some View {
        TitleView(
            element: .init(
                text: titleText,
                size: width.digitsSize(isPreview: isPreview) * .titleToDigitsRatio,
                color: render.textsColor,
                weight: .thin
            )
        )
    }
    func showCountdown(width: CGFloat, with render: UIModel.RenderSettings) -> some View {
        CountdownView(
            now: now,
            settings: settings,
            render: render,
            digitsSize: width.digitsSize(isPreview: isPreview),
            spacing: width * .elementsSpacingRatio
        )
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
