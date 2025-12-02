//
//  SceneDelegate.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var onboardingCancellable: AnyCancellable?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        var rootVC: UIViewController
        let userSession = UserSessionImpl(
            user: User(userID: "12345678", userName: "Jane Apple"),
            loggedIn: true
        )

        onboardingCancellable = userSession.$isOnboarded
            .removeDuplicates()
            .filter { $0 }
            .sink { [weak self] _ in self?.switchToHome() }

        if userSession.isOnboarded == false {
            let onboardingService = OnboardingServiceImpl(userSession: userSession)
            rootVC = onboardingService.createOnboardingFlow()
        } else {
            rootVC = createHomeVC()
        }

        let nav = UINavigationController(rootViewController: rootVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()

        self.window = window
    }

    private func createHomeVC() -> UIViewController {
        let vc = UIViewController()
        let gradientView = GradientView()
        gradientView.frame = vc.view.bounds
        vc.view.addSubview(gradientView)

        let label = UILabel()
        label.text = "Hello, World!"
        label.font = Fonts.title
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = Styling.Colors.textColor
        vc.view.addSubview(label)
        label.center = vc.view.center
        return vc
    }

    private func switchToHome() {
        window?.rootViewController = UINavigationController(rootViewController: createHomeVC())
        window?.makeKeyAndVisible()
    }
}


