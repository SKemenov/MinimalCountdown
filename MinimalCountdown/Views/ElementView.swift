//
//  ElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct ElementView: View {
    let element: UIModel.Element

    var body: some View {
        VStack(spacing: .zero) {
            TextElementView(element: digitElement)
                .digitEffect(element.render, size: element.size)
            if let labelElement {
                TextElementView(element: labelElement)
                    .foregroundStyle(labelElement.color)
                    .textCase(.uppercase)
            }
        }
    }
}

private extension ElementView {
    var digitElement: UIModel.TextElement {
        .init(
            text: element.digits,
            size: element.size,
            color: element.render.digitsColor,
            weight: element.render.digitsWeight,
            design: element.render.digitsDesign
        )
    }

    var labelElement: UIModel.TextElement? {
        element.render.isLabelHidden ? nil : .init(
            text: element.label,
            size: element.size * (element.render.isNeedFixLabelSize ? .nonLatinLabelsToDigitsRatio : .labelsToDigitsRatio),
            color: element.render.textsColor
        )
    }
}

#Preview {
    ElementView(
        element: .init(digits: "42", label: "DAYS", size: 180, render: .init(.default))
    )
    .frame(width: 240, height: 240)
    .background(Color.black)
}
