//
//  RepositoryViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit

final class RepositoryViewController: UIViewController{
    struct Dependency {
        var getRepoUseCase: GetRepoUseCase = GetRepoDefaultUseCase()
    }
    
    @IBOutlet var actorImage: UIImageView!
    @IBOutlet var eventBackground: UIView!
    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var actorName: UILabel!
    @IBAction func detailButtonTouchUpInside(_ sender: Any) {
    }
    
    @IBOutlet var repoOwnerImage: UIImageView!
    @IBOutlet var repoName: UILabel!
    @IBOutlet var repoDescription: UILabel!
    
    private let dependency: Dependency
    private let event: Event
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repository"
        fetchEvents()
    }
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, dependency: Dependency, event: Event) {
        self.dependency = dependency
        self.event = event
        super.init(coder: coder)!
    }
}

// MARK: - Instantiate

extension RepositoryViewController {
    static func instantiate(dependency: Dependency = .init(), _ event: Event) -> Self {
        R.storyboard.repository().instantiateInitialViewController{ coder in
            Self(coder: coder, dependency: dependency, event: event)
        }!
    }
}

// MARK: - Private

extension RepositoryViewController {
    private func fetchEvents() {
        dependency.getRepoUseCase.perform(ownerRepo: event.repo.name) { [weak self] result in
            switch result {
            case .success(let events):
                print(">>>>>\(events)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

