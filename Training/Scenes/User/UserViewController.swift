//
//  UserViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import UIKit

final class UserViewController: UIViewController{
    struct Dependency {
//        var getUserUseCase: GetUserUseCase = GetUserDefaultUseCase()
//        var getUserReposUseCase: GetUserReposUseCase = GetUserReposDefaultUseCase()
    }
    
    private let dependency: Dependency
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, dependency: Dependency) {
        self.dependency = dependency
        super.init(coder: coder)!
    }
}
// MARK: - Instantiate

extension UserViewController {
    static func instantiate(dependency: Dependency = .init()) -> Self {
        R.storyboard.user().instantiateInitialViewController { coder in
            Self(coder: coder, dependency: dependency)
        }!
    }
}
