//
//  IntroSegmentView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 28/11/2025.
//

import UIKit

/// A cell that displays user journey in the final step of the onboarding process
final class NewUserInfoCell: UIControl {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let labelStack = UIStackView()
    private let emojiLabel = UILabel()
    var journeyOption: ProficiencyLevel.Journey

    init(journeyOption: ProficiencyLevel.Journey) {
        self.journeyOption = journeyOption
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Metrics.Radius.buttonCornerRadius
    }

    override var isSelected: Bool {
        didSet { updateSelectionAppearance() }
    }

    func configure(with model: NewUserInfoModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        bodyLabel.text = model.body
        emojiLabel.text = model.emoji
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let point = touches.first?.location(in: self), bounds.contains(point) else { return }
        isSelected.toggle()
        sendActions(for: .touchUpInside)
    }

    //MARK: - Private interfaces

    private func setupView() {
        labelStack.axis = .vertical
        labelStack.spacing = 8
        labelStack.alignment = .fill
        addSubview(labelStack)

        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(bodyLabel)
        labelStack.addArrangedSubview(subtitleLabel)

        emojiLabel.textAlignment = .center
        emojiLabel.font = .systemFont(ofSize: 48)
        addSubview(emojiLabel)

        [titleLabel, bodyLabel, emojiLabel, subtitleLabel, labelStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        titleLabel.font = Fonts.smallBoldControl
        titleLabel.textColor = Styling.Colors.textColor

        bodyLabel.font = Fonts.smallControl
        bodyLabel.numberOfLines = 0
        bodyLabel.lineBreakMode = .byWordWrapping
        bodyLabel.textColor = Styling.Colors.textColor

        subtitleLabel.font = Fonts.smallControl
        subtitleLabel.textColor = .systemGray

        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemGray.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = Metrics.Radius.buttonCornerRadius
        backgroundColor = Styling.Colors.backgroundPrimaryColor
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.xSmall),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emojiLabel.widthAnchor.constraint(equalToConstant: Metrics.Sizing.cellImageWidth),
            emojiLabel.heightAnchor.constraint(equalToConstant: Metrics.Sizing.cellImageWidth),
            emojiLabel.trailingAnchor.constraint(equalTo: labelStack.leadingAnchor, constant: -Metrics.Spacing.xSmall),

            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Metrics.Spacing.xSmall),
            labelStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Metrics.Spacing.xSmall)
        ])
    }

    private func updateSelectionAppearance() {
        let color = isSelected ? Styling.Colors.buttonPrimaryColor.cgColor : UIColor.systemGray.cgColor
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = color
        animation.duration = 0.18
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = color
    }
}

@available(iOS 17, *)
#Preview {
    NewUserInfoCell(journeyOption: .journey1)
}
