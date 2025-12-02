//
//  OnboardingViewController.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//
import UIKit
import Combine

/// A view controller that manages the onboarding process.
/// It hosts the onboarding step view controller and the activity view with button
/// 
class OnboardingViewController: UIViewController {
    private let viewModel: OnboardingViewModel
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var stepVC: OnboardingStepViewController!
    private var actionView: ActionView!
    private var background: GradientView!
    private var cancellables = Set<AnyCancellable>()
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViews()
        setupConstraints()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        activateConstraints(for: view.bounds.size)
        updateScrollBehavior(for: view.bounds.size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.activateConstraints(for: size)
            self.updateScrollBehavior(for: size)
            self.view.layoutIfNeeded()
        })
    }

    func selectedLevel(_ level: ProficiencyLevel) {
        actionView.toggleButtonStatus(enabled: true)
    }

    // MARK: - Private interfaces

    private func setupViews() {
        background = GradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        stepVC = OnboardingStepViewController(viewModel: viewModel)
        stepVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(stepVC)
        contentView.addSubview(stepVC.view)
        stepVC.didMove(toParent: self)

        actionView = ActionView()
        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionView.setButtonTitle(Copy.Common.continueTitle)
        actionView.setButtonAction(continueButtonTapped)
        view.addSubview(actionView)
    }

    private func continueButtonTapped() {
        viewModel.advanceStep()
    }

    private func setupConstraints() {
        let safe = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: Metrics.Spacing.small),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            stepVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            stepVC.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stepVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        portraitConstraints = [
            scrollView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -Metrics.Spacing.small),
            scrollView.bottomAnchor.constraint(equalTo: actionView.topAnchor, constant: -Metrics.Spacing.small),
            actionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.Spacing.small),
            actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.Spacing.small),
            actionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -Metrics.Spacing.mediumLarge)
        ]

        landscapeConstraints = [
            scrollView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            actionView.leadingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Metrics.Spacing.small),
            actionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -Metrics.Spacing.small),
            actionView.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            actionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ]

        activateConstraints(for: view.bounds.size)
        updateScrollBehavior(for: view.bounds.size)
    }


    private func setupBindings() {
        viewModel.statePublisher
            .compactMap(\.step)
            .receive(on: RunLoop.main)
            .sink { [weak self] step in
                self?.apply(step)
            }
            .store(in: &cancellables)

        viewModel.statePublisher
            .compactMap(\.level)
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] level in
                self?.selectedLevel(level)
            }
            .store(in: &cancellables)
    }

    private func activateConstraints(for size: CGSize) {
        NSLayoutConstraint.deactivate(portraitConstraints + landscapeConstraints)
        if size.width > size.height {
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }

    private func updateScrollBehavior(for size: CGSize) {
        let isLandscape = size.height < size.width
        scrollView.isScrollEnabled = isLandscape
    }

    private func apply(_ step: OnboardingStep) {
        switch step {
        case .none:
            actionView.setButtonTitle(Copy.Common.continueTitle)
            actionView.setLabelTitle(Copy.Onboarding.welcomeTitle)
        case .one:
            actionView.setButtonTitle(Copy.Common.continueTitle)
            actionView.setLabelTitle("")
        case .two:
            actionView.setButtonTitle(Copy.Onboarding.goButton)
            actionView.setLabelTitle("")
            actionView.toggleButtonStatus(enabled: false)
        case .three:
            actionView.setButtonTitle(Copy.Common.doneTitle)
            actionView.setLabelTitle("")
        }
    }
}
