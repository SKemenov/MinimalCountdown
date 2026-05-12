//
//  BrightnessSlider.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct BrightnessSlider: View {
    private let titleResource: String
    @Binding var selection: Brightness

    init(_ titleResource: String, selection: Binding<Brightness>) {
        self.titleResource = titleResource
        self._selection = selection
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.xxSmall) {
            Slider(
                value: sliderBinding,
                in: Brightness.low.sliderValue...Brightness.high.sliderValue,
                step: 1
            ) {
                Text(titleResource)
            } minimumValueLabel: {
                Image(systemName: "sun.min.fill")
            } maximumValueLabel: {
                Image(systemName: "sun.max.fill")
            }

            Text(selection.label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private extension BrightnessSlider {
    var sliderBinding: Binding<Double> {
        Binding(
            get: { selection.sliderValue },
            set: { selection = Brightness(Int($0)) }
        )
    }
}

#Preview("Dynamic") {
    @State @Previewable var brightness: Brightness = .medium
    BrightnessSlider(Resources.Copy.Theme.brightness, selection: $brightness)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
