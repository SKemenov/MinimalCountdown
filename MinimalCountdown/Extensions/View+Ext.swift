//
//  View+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import SwiftUI

extension View {
    var subtitleFont: some View {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
    }

    /// Applies the digit `EffectStyle` from `RenderSettings`: fill + glow / blur / inner glow.
    /// Digits only — the parent owns `foregroundStyle` so each effect fully controls the fill.
    /// `backlight` and `innerGlow` always fill with black so the digit body reads on any background.
    @ViewBuilder
    func digitEffect(_ render: UIModel.RenderSettings, size: CGFloat) -> some View {
        switch render.effect {
            case .none:
                foregroundStyle(render.digitsColor)

            case .glow:
                foregroundStyle(render.digitsColor)
                    .glow(render.effectGlow, size: size)

            case .backlight:
                foregroundStyle(Color.black)
                    .glow(render.effectGlow, size: size)

            case .blur:
                foregroundStyle(render.digitsColor)
                    .blurGlow(render.effectGlow, size: size)

            case .innerGlow:
                foregroundStyle(innerGlow(render.effectGlow, size: size))
        }
    }

    /// Dense, compressed colored glow — few tight core layers + a wider spread.
    private func glow(_ color: Color, size: CGFloat) -> some View {
        self
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowSpreadRatio)
    }

    /// Wider glow used behind blurred digits.
    private func blurGlow(_ color: Color, size: CGFloat) -> some View {
        self
            .blur(radius: size * .blurRatio)
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowSpreadRatio)
    }

    /// Sharp edges with inner glow.
    private func innerGlow(_ color: Color, size: CGFloat) -> some ShapeStyle {
        Color.black
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowSpreadRatio))
            .shadow(.inner(color: color, radius: size * .innerGlowSpreadRatio))
    }
}
