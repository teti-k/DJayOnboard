//
//  HeroContentView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 26/11/2025.
//

import UIKit

/// A view with hero logo that is used for a welcoming experience.
final class HeroContentView: UIView {
    private var stack: UIStackView!
    private var logoImageView: UIImageView!
    private var logoTopConstraint: NSLayoutConstraint!

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        logoImageView = UIImageView(image: .logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        addSubview(logoImageView)

        stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Metrics.Spacing.small
        stack.distribution = .fill
        addSubview(stack)

        let label = UILabel()
        label.text = Copy.Onboarding.subtitle
        label.font = Fonts.title
        label.textColor = Styling.Colors.textColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        let heroImage = UIImageView(image: .hero)
        heroImage.contentMode = .scaleAspectFit

        let adaImage = UIImageView(image: .ada)
        adaImage.contentMode = .scaleAspectFit

        stack.addArrangedSubview(heroImage)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(adaImage)
        stack.isHidden = true

        NSLayoutConstraint.activate([
            heroImage.heightAnchor.constraint(equalToConstant: Metrics.Sizing.heroImageHeight),
            logoImageView.heightAnchor.constraint(equalToConstant: Metrics.Sizing.cellImageWidth),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Metrics.Spacing.small),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.Spacing.small)
        ])
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 200)
        logoTopConstraint.isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout(for: .zero)
    }

    func updateLayout(for size: CGSize) {
        guard stack.isHidden else { return }
        let isLandscape = traitCollection.verticalSizeClass == .compact
        logoTopConstraint.constant = isLandscape ? Metrics.Spacing.large : 200
    }

    func showFullContent() {
        stack.isHidden = false
        logoTopConstraint.constant = Metrics.Spacing.large
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.layoutIfNeeded()
        }
    }
}

@available(iOS 17, *)
#Preview {
    let view = HeroContentView()
    view.backgroundColor = .black
    return view
}

