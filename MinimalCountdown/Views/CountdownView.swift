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
    let digitsSize: CGFloat
    let spacing: CGFloat

    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(visibleElements) { style in
                ElementView(
                    digits: digits(for: style),
                    label: style.label,
                    size: digitsSize,
                    digitsColor: settings.theme.digitsColor,
                    textsColor: settings.theme.textsColor
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
        switch style {
            case .days: settings.schedule.target.daysString(relativeTo: now)
            case .hours: settings.schedule.target.hoursString(relativeTo: now)
            case .minutes: settings.schedule.target.minutesString(relativeTo: now)
            case .seconds: settings.schedule.target.secondsString(relativeTo: now)
        }
    }
}

#Preview {
    let windowWidth: CGFloat = 500
    CountdownView(
        now: Date(),
        settings: SaverSettings.default,
        digitsSize: windowWidth.digitsSize(isPreview: false),
        spacing: windowWidth * .elementsSpacingRatio
    )
    .frame(width: windowWidth, height: 300)
}
