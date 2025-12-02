//
//  GradientView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//
import UIKit

/// A view that displays a vertical gradient background for the whole Onboaridng flow
final class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.colors = [
            Styling.Colors.backgroundSecondaryColor.cgColor,    // top
            Styling.Colors.backgroundPrimaryColor.cgColor // bottom
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
