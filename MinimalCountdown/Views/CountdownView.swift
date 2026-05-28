//
//  CountdownView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct CountdownView: View {
    let now: Date
    let settings: SaverSettings
    let render: UIModel.RenderSettings
    let digitsSize: CGFloat
    let spacing: CGFloat

    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(visibleElements) { style in
                ElementView(
                    element: .init(
                        digits: digits(for: style),
                        label: labels(for: style),
                        size: digitsSize,
                        render: render
                    )
                )
            }
        }
    }
}

private extension CountdownView {
    var visibleElements: [AppearanceStyle] {
        switch settings.appearance.style {
            case .days: [.days]
            case .hours: [.days, .hours]
            case .minutes: [.days, .hours, .minutes]
            case .seconds: AppearanceStyle.allCases
        }
    }

    func digits(for style: AppearanceStyle) -> String {
        let value = switch style {
            case .days: settings.schedule.target.days(relativeTo: now)
            case .hours: settings.schedule.target.hours(relativeTo: now)
            case .minutes: settings.schedule.target.minutes(relativeTo: now)
            case .seconds: settings.schedule.target.seconds(relativeTo: now)
        }
        return UIModel.formattedDigits(value, in: render.countdownLocale)
    }

    func labels(for style: AppearanceStyle) -> String {
        UIModel.formattedLabels(style.label, in: render.countdownLocale)
    }
}

#Preview {
    let windowWidth: CGFloat = 500
    CountdownView(
        now: Date(),
        settings: SaverSettings.default,
        render: .init(.default),
        digitsSize: windowWidth.digitsSize(isPreview: false),
        spacing: windowWidth * .elementsSpacingRatio
    )
    .frame(width: windowWidth, height: 300)
}
