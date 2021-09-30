import UIKit
import Combine

final class MainViewController: UIViewController {
    typealias ViewModel = MainViewModel.TypeErased
    private typealias SectionType = MainViewModel.SectionType
    private typealias TableViewDataSource = UITableViewDiffableDataSource<SectionType, Event>
    private typealias TableViewSnapShot = NSDiffableDataSourceSnapshot<SectionType, Event>
    
    private let viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []

    @IBOutlet private var tableView: UITableView!
    private lazy var dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventTableViewCell, for: indexPath)!
        cell.event(element)
        return cell
    }
//a
    //bbbb
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.send(action: .fetch)
    }
}

// MARK: - Setup

private extension MainViewController {
    func setupUI() {
        tableView.register(R.nib.eventTableViewCell)
        tableView.dataSource = dataSource
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        navigationItem.title = "Events"
    }
    
    func bind() {
        viewModel.statePublisher.map(\.sections)
            .removeDuplicates()
            .sink{ [weak self] sections in
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

// MARK: - Instantiate

extension MainViewController {
    static func instantiate(viewModel: ViewModel = MainViewModel().eraseToAnyViewModel()) -> Self {
        R.storyboard.main().instantiateInitialViewController {
            Self(coder: $0, viewModel: viewModel)
        }!
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionType = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let event = dataSource.snapshot().itemIdentifiers(inSection: sectionType)[indexPath.row]
        let viewController = RepositoryViewController.instantiate(argument: .init(event: event))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

