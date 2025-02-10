//
//  TextElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TextElementView: View {
    let text: String
    let size: CGFloat
    let color: Color
    var weight: Font.Weight = .ultraLight

    var body: some View {
        Text(text)
            .font(.system(size: size, weight: weight))
            .monospacedDigit()
            .foregroundStyle(color)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

#Preview {
    TextElementView(text: "42", size: 180, color: .white)
    TextElementView(text: "42", size: 180, color: .white)
}
