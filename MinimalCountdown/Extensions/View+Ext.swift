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

    /// Applies the digit `EffectStyle` from `RenderSettings`: fill + glow / blur / inner shadow.
    /// Digits only — the parent owns `foregroundStyle` so each effect fully controls the fill.
    /// `backlight` and `innerShadow` always fill with black so the digit body reads on any background.
    @ViewBuilder
    func digitEffect(_ render: UIModel.RenderSettings, size: CGFloat) -> some View {
        switch render.effect {
            case .none:
                foregroundStyle(render.digitsColor)
            case .shadow:
                foregroundStyle(render.digitsColor)
                    .glow(render.effectGlow, size: size)
            case .backlight:
                foregroundStyle(Color.black)
                    .glow(render.effectGlow, size: size)
            case .blur:
                foregroundStyle(render.digitsColor)
                    .blur(radius: size * .blurRatio)
                    .blurGlow(render.effectGlow, size: size)
            case .innerShadow:
                foregroundStyle(
                    Color.black
                        .shadow(.inner(color: render.effectGlow, radius: size * .innerShadowRatio))
                        .shadow(.inner(color: render.effectGlow, radius: size * .innerShadowRatio))
                        .shadow(.inner(color: render.effectGlow, radius: size * .innerShadowRatio))
                )
        }
    }

    /// Dense, compressed colored glow — two tight core layers + a wider spread.
    private func glow(_ color: Color, size: CGFloat) -> some View {
        shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowCoreRatio)
            .shadow(color: color, radius: size * .glowSpreadRatio)
    }

    /// Wider glow used behind blurred digits.
    private func blurGlow(_ color: Color, size: CGFloat) -> some View {
        shadow(color: color, radius: size * .blurGlowCoreRatio)
            .shadow(color: color, radius: size * .blurGlowSpreadRatio)
    }
}
