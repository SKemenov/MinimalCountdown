//
//  TextElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TextElementView: View {
    let element: UIModel.TextElement

    // Pure text-shape leaf. The parent owns `foregroundStyle` (see `digitEffect`) so digit
    // effects — backlight fill, innerShadow — can fully control the fill.
    var body: some View {
        Text(element.text)
            .font(.system(size: element.size, weight: element.weight, design: element.design))
            .monospacedDigit()
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

#Preview {
    VStack {
        TextElementView(element: .init(text: "42", size: 180, color: .white))
        TextElementView(element: .init(text: "42", size: 180, color: .white, weight: .heavy, design: .rounded))
    }
    .foregroundStyle(.white)
    .padding()
    .background(.black)
}
