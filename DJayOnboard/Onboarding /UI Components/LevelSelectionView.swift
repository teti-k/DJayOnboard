//
//  LevelSelectionView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 27/11/2025.
//
import UIKit

/// A view that allows users to select their proficiency level.
final class LevelSelectionView: UIView {
    private let stackView = UIStackView()
    private var selectedControl: OptionControl?
    private var currentLevel: ProficiencyLevel?
    private var onSelection: ((ProficiencyLevel) -> Void)?

    init(onSelection: ((ProficiencyLevel) -> Void)? = nil) {
        self.onSelection = onSelection
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.Spacing.xSmall
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        ProficiencyLevel.allCases.forEach { level in
            let control = OptionControl(title: level.uiName)
            control.translatesAutoresizingMaskIntoConstraints = false
            control.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
            // we tag but idealy we want a dedicated field just like in NewUserInfoCell
            control.tag = level.hashValue
            stackView.addArrangedSubview(control)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc private func levelButtonTapped(_ sender: OptionControl) {
        selectedControl?.isSelected = false
        sender.isSelected = true
        selectedControl = sender
        if let level = ProficiencyLevel.allCases.first(where: { $0.hashValue == sender.tag }) {
            currentLevel = level
            onSelection?(level)
        }
    }
}

@available(iOS 17, *)
#Preview {
    LevelSelectionView()
}
