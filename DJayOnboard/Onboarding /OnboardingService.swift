//
//  OnboardingService.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//
import UIKit

/// A service that orchestrates the onboarding flow.
/// It creates the onboarding view controller and provides it to the caller(navogation stack)
protocol OnboardingService {
    func createOnboardingFlow() -> UIViewController
}

final class OnboardingServiceImpl: OnboardingService {
    private let userSession: UserSession
    
    init(userSession: UserSession) {
        self.userSession = userSession
    }
    
    func createOnboardingFlow() -> UIViewController {
        let onboardingViewModel = OnboardingViewModel(userSession: userSession)
        let vc = OnboardingViewController(viewModel: onboardingViewModel)
        return vc
    }
}
