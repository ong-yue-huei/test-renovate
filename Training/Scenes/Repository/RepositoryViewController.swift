//
//  RepositoryViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit
import Nuke
import Combine

final class RepositoryViewController: UIViewController {
    typealias ViewModel = RepositoryViewModel.TypeErased
    
    @IBOutlet private var actorImage: UIImageView!
    @IBOutlet private var eventBackground: UIView!
    @IBOutlet private var eventLabel: UILabel!
    @IBOutlet private var actorName: UILabel!
    @IBAction private func detailButtonTouchUpInside(_ sender: Any) {
        let viewController = UserViewController.instantiate(username: event.actor.login)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationController?.present(navigationViewController, animated: true)
    }
    
    @IBOutlet private var repoOwnerImage: UIImageView!
    @IBOutlet private var repoName: UILabel!
    @IBOutlet private var repoDescription: UILabel!
    
    @IBOutlet private var stargazersView: RepositoryCountView!
    @IBOutlet private var watchersView: RepositoryCountView!
    @IBOutlet private var forksView: RepositoryCountView!
    
    @IBOutlet private var privateView: RepositoryOtherView!
    @IBOutlet private var languageView: RepositoryOtherView!
    @IBOutlet private var issueView: RepositoryOtherView!
    @IBOutlet private var dateView: RepositoryOtherView!

    private let event: Event
    private let viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.send(action: .fetch(event: event))
    }
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, viewModel: ViewModel, event: Event) {
        self.event = event
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
}

// MARK: - Instantiate

extension RepositoryViewController {
    static func instantiate(viewModel: ViewModel = RepositoryViewModel().eraseToAnyViewModel(), _ event: Event) -> Self {
            R.storyboard.repository().instantiateInitialViewController {
                Self(coder: $0, viewModel: viewModel, event: event)
            }!
        }
}

// MARK: - Setup

private extension RepositoryViewController {
    func setupUI() {
        actorImage.layer.cornerRadius = actorImage.frame.size.width * 0.5
        eventBackground.layer.cornerRadius = 3;
        repoOwnerImage.layer.cornerRadius = repoOwnerImage.frame.size.width * 0.5
    }
    
    func bind() {
        viewModel.statePublisher.compactMap(\.repo)
            .sink{ [weak self] repo in
                self?.updateRepository(repo: repo)
            }
            .store(in: &cancellables)
    }
    
    func updateRepository(repo: Repo) {
        navigationItem.title = repo.fullName
        
        Nuke.loadImage(with: event.actor.avatarUrl, into: actorImage)
        eventLabel.text = event.type
        actorName.text = event.actor.login
        
        Nuke.loadImage(with: repo.owner.avatarURL, into: repoOwnerImage)
        repoName.text = repo.name
        repoDescription.text = repo.description
        
        stargazersView.setInfo(type: .stargazers, count: repo.stargazersCount)
        watchersView.setInfo(type: .watchers, count: repo.watchersCount)
        forksView.setInfo(type: .forks, count: repo.forksCount)
        
        privateView.setInfo(type: .isPrivate(repo.isPrivate))
        languageView.setInfo(type: .language(repo.language))
        issueView.setInfo(type: .issue(repo.openIssuesCount))
        dateView.setInfo(type: .date(repo.updatedAt))
    }
}
