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
    static var isSmallScreen: Bool {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        return (height == 568 || height == 667) && width <= 375
    }

    static var title: UIFont {
        let size: CGFloat = isSmallScreen ? 20 : 34
        return UIFont(name: "SFProDisplay-Bold", size: size) ??
            .systemFont(ofSize: size, weight: .bold)
    }

    static var body: UIFont {
        let size: CGFloat = isSmallScreen ? 18 : 22
        return UIFont(name: "SFProDisplay-Regular", size: size) ??
            .systemFont(ofSize: size, weight: .regular)
    }
    static var button: UIFont {
        let size: CGFloat = isSmallScreen ? 14 : 17
        return UIFont(name: "SFProText-Primary Action", size: size) ??
            .systemFont(ofSize: size, weight: .semibold)
    }
    static var smallControl: UIFont {
        let size: CGFloat = isSmallScreen ? 14 : 17
        return UIFont(name: "SFProDisplay-Regular", size: size) ??
            .systemFont(ofSize: size, weight: .regular)
    }
    static var smallBoldControl: UIFont {
        let size: CGFloat = isSmallScreen ? 14 : 17
        return UIFont(name: "SFProDisplay-Semibold", size: size) ??
            .systemFont(ofSize: size, weight: .semibold)
    }
}

enum Metrics {
    static var isSmallScreen: Bool {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        return (height == 568 || height == 667) && width <= 375
    }
    enum Spacing {
        static var xSmall: CGFloat { isSmallScreen ? 8 : 16 }
        static var small: CGFloat { isSmallScreen ? 16: 32 }
        static var medium: CGFloat { isSmallScreen ? 21 : 42}
        static var mediumLarge: CGFloat { isSmallScreen ? 24 : 48 }
        static var large: CGFloat { isSmallScreen ? 32 : 64 }
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
