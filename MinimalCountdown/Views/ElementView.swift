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
    let isLabelHidden: Bool
    let digitsColor: Color
    let textsColor: Color
    let digitsWeight: Font.Weight
    let digitsDesign: Font.Design

    var body: some View {
        VStack(spacing: .zero) {
            TextElementView(
                text: digits,
                size: size,
                color: digitsColor,
                weight: digitsWeight,
                design: digitsDesign
            )
            if !isLabelHidden {
                TextElementView(text: label, size: labelTextSize, color: textsColor)
            }
        }
    }

    var labelTextSize: CGFloat { size * .labelsToDigitsRatio }
}

#Preview {
    ElementView(
        digits: "42",
        label: "DAYS",
        size: 180,
        isLabelHidden: false,
        digitsColor: .white,
        textsColor: .white.opacity(0.7),
        digitsWeight: .ultraLight,
        digitsDesign: .default
    )
    .frame(width: 240, height: 240)
    .background(Color.black)
}
