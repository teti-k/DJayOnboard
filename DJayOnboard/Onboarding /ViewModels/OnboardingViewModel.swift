//
//  OnboardingViewModel.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//
import Combine
import Foundation

enum OnboardingStep: Int {
    case none = 0
    case one
    case two
    case three
}

enum ProficiencyLevel: String, Codable, CaseIterable {
    case beginner
    case experienced
    case professional

    enum Journey: Int, Codable, CaseIterable {
        case journey1
        case journey2
        case journey3
    }

    var journeys: [Journey] {
        return Journey.allCases
    }

    var uiName: String {
        switch self {
        case .beginner:
            return Copy.Onboarding.newLevel
        case .experienced:
            return Copy.Onboarding.knowledgeableLevel
        case .professional:
            return Copy.Onboarding.proLevel
        }
    }
}

final class OnboardingViewModel {
    struct State {
        var step: OnboardingStep
        var level: ProficiencyLevel?
    }
    private var userSession: UserSession
    private let stateSubject = CurrentValueSubject<State, Never>(.init(step: .none, level: nil))
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    var currentStep: OnboardingStep { stateSubject.value.step }
    var selectedLevel: ProficiencyLevel? { stateSubject.value.level }

    init(
        userSession: UserSession
    ) {
        self.userSession = userSession
    }

    func advanceStep() {
        var snapshot = stateSubject.value
        if snapshot.step == .three {
            completeOnboarding()
        }
        snapshot.step = OnboardingStep(rawValue: snapshot.step.rawValue + 1) ?? .three
        stateSubject.send(snapshot)
    }

    func setStep(_ step: OnboardingStep) {
        var snapshot = stateSubject.value
        snapshot.step = step
        stateSubject.send(snapshot)
    }

    func selectLevel(_ level: ProficiencyLevel) {
        userSession.updateUserLevel(level)
        var snapshot = stateSubject.value
        snapshot.level = level
        stateSubject.send(snapshot)
    }

    func selectJourney(_ journey: ProficiencyLevel.Journey) {
        // select journey and update the navigation ?
    }

    func completeOnboarding() {
        userSession.setFinishedOnboarding()
    }
}
