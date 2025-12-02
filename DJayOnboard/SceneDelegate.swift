//
//  SceneDelegate.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//

import UIKit
import Combine

enum OnboardingLaunchMode {
    /// Use UserDefaults
    case normal
    /// Always launch onboarding
    case alwaysOnboarding
}

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
        let userSession = UserSessionImpl(
            user: User(userID: "12345678", userName: "Jane Apple"),
            loggedIn: true
        )

        onboardingCancellable = userSession.$isOnboarded
            .removeDuplicates()
            .filter { $0 }
            .sink { [weak self] _ in self?.switchToHome() }

        // MARK: - Change `normal` to `alwaysOnboarding` to always load the onboarding screen
        let rootVC = makeRootViewController(.alwaysOnboarding, userSession)
        let navigationController = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigationController

        let navigationVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()

        self.window = window
    }

    private func makeRootViewController(_ launchMode: OnboardingLaunchMode, _ userSession: UserSession) -> UIViewController {
        if launchMode == .normal && userSession.isOnboarded == true {
            return createHomeVC()
        } else {
            let onboardingService = OnboardingServiceImpl(userSession: userSession)
            return onboardingService.createOnboardingFlow()
        }
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


