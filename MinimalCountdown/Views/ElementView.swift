//
//  ElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ElementView: View {
    let digits: String
    let label: String
    let size: CGFloat
    let digitsColor: Color
    let textsColor: Color

    var body: some View {
        VStack(spacing: .zero) {
            TextElementView(text: digits, size: size, color: digitsColor, weight: .thin)
            TextElementView(text: label, size: textsSize, color: textsColor)
        }
    }

    var textsSize: CGFloat { size / 5 }
}

#Preview {
    ElementView(
        digits: "42",
        label: "DAYS",
        size: 180,
        digitsColor: .white,
        textsColor: .white.opacity(0.7),
    )
    .frame(width: 240, height: 240)
    .background(Color.black)
}
