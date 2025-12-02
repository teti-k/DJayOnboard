//
//  Styling.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 26/11/2025.
//
import UIKit

enum Styling {
    enum Colors {
        static let backgroundSecondaryColor = UIColor(red: 2/255, green: 2/255, blue: 3/255, alpha: 1)
        static let backgroundPrimaryColor = UIColor(red: 80/255, green: 80/255, blue: 115/255, alpha: 1)
        static let buttonPrimaryColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        static let semiTransparentBackgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        static let textColor = UIColor.white
    }
}

enum Fonts {
    static let title: UIFont = UIFont(name: "SFProDisplay-Bold", size: 34) ??
        .systemFont(ofSize: 34, weight: .bold)
    static let body: UIFont = UIFont(name: "SFProDisplay-Regular", size: 22) ??
        .systemFont(ofSize: 22, weight: .regular)
    static let button: UIFont = UIFont(name: "SFProText-Primary Action", size: 17) ??
        .systemFont(ofSize: 17, weight: .semibold)
    static let smallControl: UIFont = UIFont(name: "SFProDisplay-Regular", size: 17) ??
        .systemFont(ofSize: 17, weight: .regular)
    static let smallBoldControl: UIFont = UIFont(name: "SFProDisplay-Semibold", size: 17) ??
        .systemFont(ofSize: 17, weight: .semibold)
}

enum Metrics {
    enum Spacing {
        static let xSmall: CGFloat = 16
        static let small: CGFloat = 32
        static let medium: CGFloat = 42
        static let mediumLarge: CGFloat = 48
        static let large: CGFloat = 64
    }
    enum Radius {
        static let buttonCornerRadius: CGFloat = 12
    }

    enum Sizing {
        static let buttonHeight: CGFloat = 44
        static let optionControlHeight: CGFloat = 48
        static let radioButtonWidth: CGFloat = 24
        static let radioButtonBorderWidth: CGFloat = 2
        static let cellImageWidth: CGFloat = 64
        static let heroImageHeight: CGFloat = 140
    }
}

enum Copy {
    enum Onboarding {
        static let welcomeTitle = "Welcome to djay"
        static let welcomeTitle2 = "Welcome DJ"
        static let goButton = "Let's go"
        static let subtitle = "Mix Your Favorite Music"
        static let chooseLevelTitle = "What’s your DJ skill level?"
        static let newLevel = "I’m new to DJing"
        static let knowledgeableLevel = "I’ve used DJ apps before"
        static let proLevel = "I’m a professional DJ"
        static let journeyHeader =  "Let's get you started!"
    }
    
    enum Common {
        static let continueTitle = "Continue"
        static let doneTitle = "Done"
    }
}
