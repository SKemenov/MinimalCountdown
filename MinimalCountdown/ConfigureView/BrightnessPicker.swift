//
//  BrightnessPicker.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct BrightnessPicker: View {
    private let titleResource: String
    @Binding var selection: Brightness

    init(_ titleResource: String, selection: Binding<Brightness>) {
        self.titleResource = titleResource
        self._selection = selection
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.xxSmall) {
            Picker(titleResource, selection: $selection) {
                ForEach(Brightness.allCases) { brightness in
                    Image(systemName: brightness.iconName).tag(brightness)
                }
            }
            .pickerStyle(.segmented)

            Text(selection.label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Dynamic") {
    @State @Previewable var brightness: Brightness = .high
    BrightnessPicker(Resources.Copy.Theme.brightness, selection: $brightness)
        .padding(.Spacing.medium)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: .Spacing.medium))
        .padding(.Spacing.medium)
        .frame(width: .Sizes.settingsWidth)
}
