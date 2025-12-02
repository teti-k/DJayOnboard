//
//  IntroView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 27/11/2025.
//
import UIKit

/// A view that allows the user to choose their journey as a final step of onboarding
final class NewUserInfoView: UIView {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private var selectedControl: NewUserInfoCell?
    private var onJourneySelected: ((ProficiencyLevel.Journey) -> Void)?

    var level: ProficiencyLevel = .beginner {
        didSet { populateData() }
    }

    init(onJourneySelected: @escaping (ProficiencyLevel.Journey) -> Void) {
        self.onJourneySelected = onJourneySelected
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = true
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.title
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = Copy.Onboarding.journeyHeader
        titleLabel.textColor = Styling.Colors.textColor
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.Spacing.small),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func populateData() {
        let data = NewUserInfoViewModel.provideNextSteps(for: level)
        data.forEach { element in
            let cell = NewUserInfoCell(journeyOption: element.journeyOption)
            cell.configure(with: element)
            cell.addTarget(self, action: #selector(userInfoCellTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(cell)
        }
    }

    @objc private func userInfoCellTapped(_ sender: NewUserInfoCell) {
        selectedControl?.isSelected = false
        sender.isSelected = true
        selectedControl = sender
        onJourneySelected?(sender.journeyOption)
    }
}

@available(iOS 17, *)
#Preview {
    NewUserInfoView(onJourneySelected: {_ in} )
}
