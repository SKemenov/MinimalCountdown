//
//  View+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

extension View {
    var subtitleFont: some View {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
    }
}
