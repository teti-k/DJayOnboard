//
//  ActionView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 26/11/2025.
//
import UIKit

/// View that encapsulates the action button and its label.
/// User can change button text and hide label
final class ActionView: UIView {
    private let button: UIButton
    private let textLabel: UILabel
    private var buttonAction: () -> Void = {}

    init() {
        button = UIButton()
        textLabel = UILabel()
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Styling.Colors.buttonPrimaryColor
        button.layer.cornerRadius = Metrics.Radius.buttonCornerRadius
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = Copy.Onboarding.welcomeTitle
        textLabel.font = Fonts.body
        textLabel.textColor = Styling.Colors.textColor
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        addSubview(button)
        addSubview(textLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.xSmall),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Metrics.Spacing.xSmall),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: Metrics.Sizing.buttonHeight),
        ])
    }

    func setButtonTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }

    func setLabelTitle( _ title: String) {
        textLabel.text = title
    }

    func toggleButtonStatus(enabled: Bool) {
        button.isEnabled = enabled
        button.alpha = enabled ? 1.0 : 0.33
    }

    func setButtonAction(_ action: @escaping () -> Void) {
        buttonAction = action
    }

    @objc private func buttonTapped() {
        buttonAction()
    }
}

@available(iOS 17, *)
#Preview {
    let view = ActionView()
    view.setButtonTitle("Continue")
    view.setLabelTitle("Welcome to DJay")
    view.backgroundColor = .black
    return view
}
