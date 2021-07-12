//
//  UserViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import UIKit

final class UserViewController: UIViewController{
    struct Dependency {
        var getUserUseCase: GetUserUseCase = GetUserDefaultUseCase()
        var getUserReposUseCase: GetUserReposUseCase = GetUserReposDefaultUseCase()
    }
    
    private let dependency: Dependency
    private let username: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchUserRepos()
    }
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, dependency: Dependency, username: String) {
        self.dependency = dependency
        self.username = username
        super.init(coder: coder)!
    }
}

// MARK: - Instantiate

extension UserViewController {
    static func instantiate(dependency: Dependency = .init(), username: String) -> Self {
        R.storyboard.user().instantiateInitialViewController { coder in
            Self(coder: coder, dependency: dependency, username: username)
        }!
    }
}

// MARK: - Private

private extension UserViewController {
    func fetchUser() {
        dependency.getUserUseCase.perform(username: username) { [weak self] result in
            switch result {
            case .success(let user):
                print(">>>>>>\(user)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUserRepos() {
        dependency.getUserReposUseCase.perform(username: username) { [weak self] result in
            switch result {
            case .success(let repos):
                print("<<<<<<<<\(repos)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
