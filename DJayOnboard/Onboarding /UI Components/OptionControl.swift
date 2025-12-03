//
//  OptionControl.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 27/11/2025.
//
import UIKit

/// Control to represent an option item in selection group
///  Initialize with title
final class OptionControl: UIControl {
    private let backgroundView = UIView()
    private let borderView = UIView()
    private let circleContainer = UIView()
    private let checkmark = UIImageView()
    private let titleLabel = UILabel()

    override var isSelected: Bool {
        didSet { updateAppearance(animated: true) }
    }

    override var isHighlighted: Bool {
        didSet { updateAppearance(animated: true) }
    }

    init(title: String) {
        super.init(frame: .zero)
        commonInit()
        titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: Private interfaces

    private func commonInit() {
        isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
        updateAppearance(animated: false)
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Styling.Colors.backgroundPrimaryColor
        backgroundView.layer.cornerRadius = Metrics.Radius.buttonCornerRadius
        backgroundView.layer.masksToBounds = true

        borderView.layer.cornerRadius = Metrics.Radius.buttonCornerRadius
        borderView.layer.borderWidth = Metrics.Sizing.radioButtonBorderWidth
        borderView.layer.borderColor = Styling.Colors.buttonPrimaryColor.cgColor
        borderView.isHidden = true

        circleContainer.layer.cornerRadius = Metrics.Radius.buttonCornerRadius
        circleContainer.layer.borderWidth = Metrics.Sizing.radioButtonBorderWidth
        circleContainer.layer.borderColor = Styling.Colors.semiTransparentBackgroundColor.cgColor
        circleContainer.backgroundColor = .clear

        checkmark.image = .levelCheckmark
            .withRenderingMode(.alwaysTemplate)
        checkmark.tintColor = .white
        checkmark.isHidden = true

        titleLabel.font = Fonts.smallControl
        titleLabel.textColor = Styling.Colors.textColor

        addSubview(backgroundView)
        addSubview(borderView)
        backgroundView.addSubview(circleContainer)
        circleContainer.addSubview(checkmark)
        backgroundView.addSubview(titleLabel)

        [backgroundView, borderView, circleContainer, checkmark, titleLabel]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Metrics.Sizing.optionControlHeight),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),

            circleContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Metrics.Spacing.xSmall),
            circleContainer.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            circleContainer.widthAnchor.constraint(equalToConstant: Metrics.Sizing.radioButtonWidth),
            circleContainer.heightAnchor.constraint(equalTo: circleContainer.widthAnchor),

            checkmark.centerXAnchor.constraint(equalTo: circleContainer.centerXAnchor),
            checkmark.centerYAnchor.constraint(equalTo: circleContainer.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: circleContainer.trailingAnchor, constant: Metrics.Spacing.xSmall),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Metrics.Spacing.xSmall),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }

    private func updateAppearance(animated: Bool) {
        let changes = {
            if self.isSelected {
                self.circleContainer.backgroundColor = Styling.Colors.buttonPrimaryColor
                self.circleContainer.layer.borderWidth = 0
                self.checkmark.isHidden = false
                self.borderView.isHidden = false

            } else {
                self.circleContainer.backgroundColor = .clear
                self.circleContainer.layer.borderWidth = Metrics.Sizing.radioButtonBorderWidth
                self.circleContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
                self.checkmark.isHidden = true
                self.borderView.isHidden = true
            }
        }

        if animated {
            UIView.animate(withDuration: 0.2, animations: changes)
        } else {
            changes()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let point = touches.first?.location(in: self), bounds.contains(point) else { return }
        isSelected.toggle()
        sendActions(for: .touchUpInside)
    }
}


@available(iOS 17, *)
#Preview {
    let control = OptionControl(title: "Beginner")
    control.backgroundColor = .black
    return control
}
