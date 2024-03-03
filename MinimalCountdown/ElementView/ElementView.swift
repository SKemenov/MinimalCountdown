//
//  ElementView.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 23.02.2024.
//

import AppKit

final class ElementView: NSView {
    // MARK: - Private properties

    let digitsLabel = SSaverTextView()
    let descriptionLabel = SSaverTextView()

    // MARK: - Inits

    init() {
        super.init(frame: .zero)
        configureUI()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension ElementView {
    func configureUI() {
        [digitsLabel, descriptionLabel].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            digitsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            digitsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            digitsLabel.topAnchor.constraint(equalTo: topAnchor),
            digitsLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
