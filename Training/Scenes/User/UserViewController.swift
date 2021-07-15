//
//  UserViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import UIKit
import Combine

final class UserViewController: UIViewController{
    private enum Const {
        static let sectionIdentifier = "repos"
    }
    typealias ViewModel = UserViewModel.TypeErased
    private typealias TableViewDataSource = UITableViewDiffableDataSource<String, Repo>
    private typealias TableViewSnapShot = NSDiffableDataSourceSnapshot<String, Repo>
    
    @IBOutlet var userTableHeaderView: UserTableHeaderView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.userRepoTableViewCell)
            tableView.dataSource = dataSource
            tableView.delegate = self
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    private lazy var dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userRepoTableViewCell, for: indexPath)!
        cell.userRepo(element)
        return cell
    }
    
    private let username: String
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: ViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(username)'s Repository List"
        bind()
        viewModel.send(action: .fetch(username: username))
    }
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, viewModel: ViewModel, username: String) {
        self.viewModel = viewModel
        self.username = username
        super.init(coder: coder)!
    }
}

// MARK: - Instantiate

extension UserViewController {
    static func instantiate(viewModel: ViewModel = UserViewModel().eraseToAnyViewModel(), username: String) -> Self {
        R.storyboard.user().instantiateInitialViewController { coder in
            Self(coder: coder, viewModel: viewModel, username: username)
        }!
    }
}

// MARK: - Setup

private extension UserViewController {
    func bind() {
        viewModel.statePublisher.compactMap(\.user)
            .sink { [weak self] user in
                self?.userTableHeaderView.setUser(user)
            }
            .store(in: &cancellables)
        
        viewModel.statePublisher.map(\.sections)
            .removeDuplicates()
            .sink { [weak self] sections in
                var snapshot = TableViewSnapShot()
                snapshot.appendSections([Const.sectionIdentifier])
                snapshot.appendItems(sections, toSection: Const.sectionIdentifier)
                self?.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDelegate

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
