//
//  DateSectionView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct DateSectionView: View {
    @Binding var settings: SaverSettings

    var body: some View {
        AccessibleSection(Resources.Date.title) {
            timePicker
            Divider()
            dayPicker
        }
    }
}

private extension DateSectionView {
    var timePicker: some View {
        DatePicker(selection: $settings.schedule.target, displayedComponents: .hourAndMinute) {
            Text(Resources.Date.time)
//                .accessibilityHidden(true)
        }
        .hint(Resources.Date.timeHint)
        .accessibilityElement(children: .combine)
    }

    var dayPicker: some View {
        DatePicker(
            selection: $settings.schedule.target,
            in: Date.now.datesInBetween(),
            displayedComponents: .date
        ) {
            Text(Resources.Date.day)
            VStack(alignment: .leading) {
                Text(Resources.Date.dayHint1)
                Text(Resources.Date.dayHint2)
                Text(Resources.Date.dayHint3)
                    .lineLimit(5)
            }
            .subtitleFont
        }
        .datePickerStyle(.graphical)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    DateSectionView(settings: .constant(.default))
}
