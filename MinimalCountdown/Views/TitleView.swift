//
//  TitleView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

struct TitleView: View {
    let settings: SaverSettings
    let textSize: CGFloat
    var body: some View {
        if isTitleNeeding {
            TextElementView(
                text: formattedMessage,
                size: textSize,
                color: settings.theme.textsColor,
                weight: .thin
            )
        }
    }
}

private extension TitleView {
    var isTitleNeeding: Bool { !settings.title.isHidden && !settings.title.text.isEmpty }

    var formattedMessage: String {
        let string = settings.title.text.uppercased()
        let words = string.components(separatedBy: " ")
        let separator = string.count <= 30 ? "  " : "   "
        return words.joined(separator: separator)
    }
}

#if DEBUG
#Preview {
    TitleView(settings: SaverSettings.preview, textSize: 50)
        .frame(width: 500, height: 300)
}
#endif
