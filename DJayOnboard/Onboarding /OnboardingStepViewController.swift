//
//  OnboardingStepView.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//
import UIKit
import Combine

/// A view controller that manages the onboarding steps.
/// It navigated thrrough the hero content view, choose level content view, and new user info view.
final class OnboardingStepViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private var heroContentView: HeroContentView!
    private var chooseLevelContentView: ChooseLevelContentView!
    private var newUserInfoView: UserJourneySelectionView!
    private let viewModel: OnboardingViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupPublishers()
        setupView()
        setupConstraints()
    }

    func apply(_ step: OnboardingStep) {
        switch step {
        case .none:
            break
        case .one:
            heroContentView.showFullContent()
            scrollTo(step: .one, animated: true)
        case .two:
            scrollTo(step: .two, animated: true)
        case .three:
            scrollTo(step: .three, animated: true)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        heroContentView.updateLayout(for: size)
        coordinator.animate { [weak self] _ in
            guard let self = self else { return }
            self.scrollTo(step: self.viewModel.currentStep, animated: false)
        }
    }

    private func setupPublishers() {
        viewModel.statePublisher
            .compactMap(\.step)
            .receive(on: RunLoop.main)
            .sink { [weak self] step in
                self?.apply(step)
            }
            .store(in: &cancellables)
        viewModel.statePublisher
            .compactMap(\.level)
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] level in
                self?.newUserInfoView.level = level
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        contentStack.axis = .horizontal
        contentStack.alignment = .fill
        contentStack.distribution = .fillEqually
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        heroContentView = HeroContentView()
        chooseLevelContentView = ChooseLevelContentView(onLevelSelected: viewModel.selectLevel(_:))
        newUserInfoView = UserJourneySelectionView(onJourneySelected: viewModel.selectJourney(_:))

        [heroContentView, chooseLevelContentView, newUserInfoView].forEach { page in
            page.translatesAutoresizingMaskIntoConstraints = false
            contentStack.addArrangedSubview(page)
            page.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
            page.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
        }
    }

    private func setupConstraints() {
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),

            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }

    private func scrollTo(step: OnboardingStep, animated: Bool) {
        guard scrollView.bounds.width > 0 else { return }
        let pageIndex: CGFloat =  switch step {
        case .none, .one: 0
        case .two: 1
        case .three: 2
        }
        let targetOffset = CGPoint(x: scrollView.bounds.width * pageIndex, y: 0)
        scrollView.setContentOffset(targetOffset, animated: animated)
    }
}


