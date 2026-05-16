//
//  TextElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TextElementView: View {
    let element: UIModel.TextElement

    var body: some View {
        Text(element.text)
            .font(.system(size: element.size, weight: element.weight, design: element.design))
            .monospacedDigit()
            .foregroundStyle(element.color)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

#Preview {
    TextElementView(element: .init(text: "42", size: 180, color: .white))
    TextElementView(element: .init(text: "42", size: 180, color: .white, weight: .heavy, design: .rounded))
}
