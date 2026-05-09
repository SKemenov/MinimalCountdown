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
    let windowWidth: CGFloat
    var isPreview: Bool = false

    var body: some View {
        HStack(
            alignment: .top,
            spacing: windowWidth.calculateSize(for: .spacing, isPreview: isPreview)
        ) {
            ForEach(visibleElements) { style in
                ElementView(
                    digits: digits(for: style),
                    label: style.label,
                    size: windowWidth.calculateSize(for: .digits, isPreview: isPreview),
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
    CountdownView(now: Date(), settings: SaverSettings.default, windowWidth: 500)
        .frame(width: 500, height: 300)
}
