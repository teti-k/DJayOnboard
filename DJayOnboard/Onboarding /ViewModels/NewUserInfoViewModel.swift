//
//  InfoNewUserViewModel.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 28/11/2025.
//
import UIKit

struct NewUserInfoViewModel {
    static func provideNextSteps(for level: ProficiencyLevel) -> [NewUserInfoModel] {
        switch level {
        case .beginner:
             [
                NewUserInfoModel(
                    title: "Step by step guide",
                    subtitle: "15 min",
                    body: "Create your fist mix following our guide",
                    emoji: "🎓",
                    journeyOption: .journey1
                ),
                NewUserInfoModel(
                    title: "Watch video tutorials",
                    subtitle: "5-10 mins",
                    body: "Discover our beginner-friendly series",
                    emoji: "📺",
                    journeyOption: .journey2
                ),
                NewUserInfoModel(
                    title: "Get started",
                    subtitle: "Sandbox mode",
                    body: "Dive straight into mixing with simplified controls",
                    emoji: "🎛️",
                    journeyOption: .journey3
                )

            ]
        case .experienced:
            [
                NewUserInfoModel(
                    title: "Start new mix",
                    subtitle: "Jump into the action",
                    body: "Full control",
                    emoji: "🎛️",
                    journeyOption: .journey1
                ),
                NewUserInfoModel(
                    title: "Import projects",
                    subtitle: "",
                    body: "Bring your existing projects into the app",
                    emoji: "📂",
                    journeyOption: .journey2
                ),
                NewUserInfoModel(
                    title: "Browse Samples",
                    subtitle: "1000+ samples",
                    body: "Explore our collection of loops and sounds",
                    emoji: "🎶",
                    journeyOption: .journey3
                ),
            ]
        case .professional:
             [
                NewUserInfoModel(
                    title: "Start in Pro workspace",
                    subtitle: "Full studio",
                    body: "Enjoy our advanced features",
                    emoji: "🎛️",
                    journeyOption: .journey1
                ),
                NewUserInfoModel(
                    title: "Import projects",
                    subtitle: "",
                    body: "Bring your existing projects into the app",
                    emoji: "📂",
                    journeyOption: .journey2
                ),
                NewUserInfoModel(
                    title: "Connect your hardware",
                    subtitle: "MIDI, audio interfaces",
                    body: "Link your controllers",
                    emoji: "🔌",
                    journeyOption: .journey3
                )
            ]
        }
    }
}

struct NewUserInfoModel {
    let title: String
    let subtitle: String
    let body: String
    let emoji: String
    let journeyOption: ProficiencyLevel.Journey
}
