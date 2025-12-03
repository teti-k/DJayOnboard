# DJayOnboard

The onboarding test project. This app walks a new user through three onboarding stages: Welcome, Proficiency level, User journey selection.

## Architecture

For this project, I used MVVM, dependency injection, protocols and Combine for state management. 
The key components are: 
- `OnboardingViewController`: acts as a container for all onboarding steps and coordinates button taps with the progress of the onboarding.
- `OnboardingStepViewController`: handles switching between onboarding steps: HeroContentView, ChooseLevelContentView and UserJourneySelection.
- `OnboardingViewModel`: manages the state of the flow.
  ``` swift
  struct State {
        var step: OnboardingStep
        var level: ProficiencyLevel?
    }
  ```
- `UserSession`: encapsulates all user related information - login state, onboarding status etc. When onboarding is done, it records a key to UserDefaults.
The flow currently is setup to switch to Home screen after the onboarding is done and start from Home screen afterwards. This behavour can be changed in the `SceneDelegate`.
Choose `.alwaysOnboarding` to lauch Onboarding flow every time. 
``` swift
 let rootVC = makeRootViewController(.normal, userSession)
```
- `OnboardingService`: creates an onboarding flow and provides a viewController for navigation. It is the only entry point for the users of the onboarding.
The project also contains simple UI componets  - option control, cells etc,  - that are used across the app.
Metrics, fonts and colours can be found in `Designs.swift`.

## Remarks
For smaller size devices, I chose to scale down fonts and spacings, however, I do it in a quite hacky way: I simply observe the screen sizes. 
Ideally, I would need to utilize the size classes and adjust the veiws accoriding to them.
