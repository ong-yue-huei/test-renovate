//
//  RepositoryViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import UIKit

final class RepositoryViewController: UIViewController {
    
}

// MARK: - Instantiate

extension RepositoryViewController {
    static func instantiate() -> Self {
        R.storyboard.repository().instantiateInitialViewController()!
    }
}
