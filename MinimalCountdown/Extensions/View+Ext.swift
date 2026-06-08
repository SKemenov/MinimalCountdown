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

    var formNote: some View {
        self
            .font(.callout)
            .padding(.horizontal)
            .padding(.top, .Spacing.small)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .transition(.asymmetric(insertion: .opacity, removal: .identity))
    }

    /// Surfaces one hint to both pointer users (`.help` tooltip) and VoiceOver
    /// (`.accessibilityHint`), so they can't drift apart — and it restores the guidance lost when
    /// the visible subtitles were removed (help-only left VoiceOver with nothing).
    func hint(_ resource: LocalizedStringResource) -> some View {
        help(Text(resource)).accessibilityHint(Text(resource))
    }

    /// String overload for runtime-composed hints (e.g. `UIModel.effectsHint`).
    func hint(_ string: String) -> some View {
        help(string).accessibilityHint(string)
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
                    .glow(render.effectGlowColor, size: size)

            case .backlight:
                foregroundStyle(Color.black)
                    .glow(render.effectGlowColor, size: size)

            case .blur:
                foregroundStyle(render.digitsColor)
                    .blurGlow(render.effectGlowColor, size: size)

            case .innerGlow:
                foregroundStyle(innerGlow(render.effectGlowColor, size: size))
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
