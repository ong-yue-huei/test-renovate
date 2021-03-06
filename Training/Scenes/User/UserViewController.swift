//
//  UserViewController.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import UIKit
import Combine

final class UserViewController: UIViewController{
    typealias ViewModel = UserViewModel.TypeErased
    private typealias SectionType = UserViewModel.SectionType
    private typealias TableViewDataSource = UITableViewDiffableDataSource<SectionType, Repo>
    private typealias TableViewSnapShot = NSDiffableDataSourceSnapshot<SectionType, Repo>
    
    @IBOutlet var userTableHeaderView: UserTableHeaderView!
    @IBOutlet var tableView: UITableView!
    
    private lazy var dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userRepoTableViewCell, for: indexPath)!
        cell.userRepo(element)
        return cell
    }
    
    private let viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.send(action: .fetch)
    }
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
}

// MARK: - Instantiate

extension UserViewController {
    static func instantiate(argument: ViewModel.Argument) -> Self {
       let viewModel = UserViewModel(argument: argument)
       return instantiate(viewModel: viewModel.eraseToAnyViewModel())
    }
    
    static func instantiate(viewModel: ViewModel) -> Self {
        R.storyboard.user().instantiateInitialViewController { coder in
            Self(coder: coder, viewModel: viewModel)
        }!
    }
}

// MARK: - Setup

private extension UserViewController {
    func setupUI() {
        tableView.register(R.nib.userRepoTableViewCell)
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView(frame: .zero)
        title = "\(viewModel.argument.username)'s Repository List"
    }
    
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
                sections.forEach { section in
                    snapshot.appendSections([section.type])
                    snapshot.appendItems(section.cells, toSection: section.type)
                }
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
