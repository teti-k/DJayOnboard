//
//  Untitled.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 26/11/2025.
//
import UIKit

/// A view that allows users to choose their proficiency level.
final class ChooseLevelContentView: UIView {
    private let stack = UIStackView()
    private var didSelectLevel = false
    private var onLevelSelected: ((ProficiencyLevel) -> Void)?

    init(onLevelSelected: ((ProficiencyLevel) -> Void)? = nil) {
        self.onLevelSelected = onLevelSelected
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false

        let logoImageView = UIImageView(image: .icon)
        logoImageView.contentMode = .scaleAspectFit
        addSubview(logoImageView)

        stack.axis = .vertical
        stack.spacing = Metrics.Spacing.small
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        let headerLabel = UILabel()
        headerLabel.text = Copy.Onboarding.welcomeTitle2
        headerLabel.textColor = Styling.Colors.textColor
        headerLabel.textAlignment = .center
        headerLabel.font = Fonts.title

        let subtitleLabel = UILabel()
        subtitleLabel.text = Copy.Onboarding.chooseLevelTitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .systemGray
        subtitleLabel.font = Fonts.body

        let labelContainer = UIStackView()
        labelContainer.axis = .vertical
        labelContainer.alignment = .fill
        labelContainer.spacing = 8
        labelContainer.addArrangedSubview(headerLabel)
        labelContainer.addArrangedSubview(subtitleLabel)
        stack.addArrangedSubview(labelContainer)

        let levelSelectionView = LevelSelectionView(onSelection: onLevelSelected)
        stack.addArrangedSubview(levelSelectionView)

        [logoImageView, headerLabel, subtitleLabel, labelContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stack.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Metrics.Spacing.medium),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

@available(iOS 17, *)
#Preview {
    let v = ChooseLevelContentView()
    v.backgroundColor = .black
    return v
}

