//
//  UserSession.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//

import Foundation
import Combine

/// Represents current user of the application
protocol UserSession {
    /// Indicates whether the user is logged in
    var isLoggedIn: Bool { get }
    /// The current user object
    var user: User { get }
    /// Marks the onboarding process as finished
    func setFinishedOnboarding()
    /// Updates the user's proficiency level
    func updateUserLevel(_ level: ProficiencyLevel)
}

final class UserSessionImpl: UserSession, ObservableObject {
    let user: User
    private let onboardingKey = "kUserOnboarded"
    private var loggedIn: Bool
    @Published private(set) var isOnboarded: Bool

    init(user: User, loggedIn: Bool) {
        self.user = user
        self.loggedIn = loggedIn
        self.isOnboarded = UserDefaults.standard.bool(forKey: onboardingKey)
    }

    var isLoggedIn: Bool {
        return true
    }

    func setFinishedOnboarding() {
        isOnboarded = true
        UserDefaults().set(true, forKey: onboardingKey)
    }

    func updateUserLevel(_ level: ProficiencyLevel) {
        user.level = level
    }
}
