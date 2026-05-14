//
//  LegacySettings.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

enum LegacySettings {
    case v1(V1)
    // case v2(V2)  — future, when current becomes v3

    struct V1: Decodable, Equatable {
        var targetDate: Date
        var color: AccentColor
        var backgroundColor: BackgroundColor
        var style: AppearanceStyle
        var message: String
        var isMessageHidden: Bool
        var isBrightNormal: Bool
    }
}

extension LegacySettings {
    static func decode(version: Int, from data: Data, using decoder: JSONDecoder) throws -> LegacySettings {
        switch version {
            case 1: return .v1(try decoder.decode(V1.self, from: data))
            default: throw LegacyDecodeError.unknownVersion(version)
        }
    }

    var upgradedToCurrent: SaverSettings {
        switch self {
            case .v1(let v1): return v1.upgraded
        }
    }
}

extension LegacySettings.V1 {
    var upgraded: SaverSettings {
        SaverSettings(
            appearance: .init(style: style, isLabelHidden: false),
            schedule: .init(target: targetDate),
            theme: .init(
                accent: color,
                background: backgroundColor,
                brightness: isBrightNormal ? .high : .medium,
                effect: .none,
                effectColor: .white
            ),
            typography: .init(weight: .ultraLight, isRounded: false),
            title: .init(text: message, isHidden: isMessageHidden)
        )
    }
}

enum LegacyDecodeError: Error {
    case unknownVersion(Int)
}
