//
//  LocalizedStringResource+Ext.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

private final class BundleToken {}

extension LocalizedStringResource.BundleDescription {
    /// Anchors `LocalizedStringResource` lookups to *this* bundle. Inside a `.saver`, `Bundle.main`
    /// is the host app (System Settings), so the default `.main` resolution silently falls back to
    /// the development-language key. `.forClass` instead resolves to the bundle a class is compiled
    /// into; `BundleToken` compiles into each target, so `.app` resolves to the saver bundle in the
    /// saver and the app bundle in DevApp.
    ///
    /// A dedicated empty token (vs. reusing an existing both-targets class like `SettingsManager`)
    /// keeps the localization concern decoupled and self-documenting at the use site.
    static let app = forClass(BundleToken.self)
}
