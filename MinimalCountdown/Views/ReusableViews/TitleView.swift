//
//  TitleView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TitleView: View {
    let element: UIModel.TextElement

    var body: some View {
        if !element.text.isEmpty {
            TextElementView(element: element)
                .foregroundStyle(element.color)
        }
    }
}

#if DEBUG
#Preview {
    TitleView(
        element: .init(
            text: UIModel.formattedTitle(SaverSettings.preview.title),
            size: 200 * .titleToDigitsRatio,
            color: UIModel.RenderSettings(.preview).textsColor,
            weight: .thin
        )
    )
    .frame(width: 500, height: 300)
}
#endif
