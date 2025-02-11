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
                color: settings.textsColor,
                weight: .thin
            )
        }
    }
}

private extension TitleView {
    var isTitleNeeding: Bool { !settings.isMessageHidden && !settings.message.isEmpty }

    var formattedMessage: String {
        let string = settings.message.uppercased()
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
