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
            if let labelElement {
                TextElementView(element: labelElement)
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
        guard !element.render.isLabelHidden else { return nil }
        return .init(
            text: element.label,
            size: element.size * .labelsToDigitsRatio,
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
