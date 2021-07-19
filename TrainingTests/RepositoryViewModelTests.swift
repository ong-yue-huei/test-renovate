//
//  RepositoryViewModelTests.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training
import XCTest

class RepositoryViewModelTests: XCTestCase {
    private var getRepoUseCase = GetRepoUseCaseMock()
    private lazy var dependency = RepositoryViewModel.Dependency(getRepoUseCase: getRepoUseCase)
   
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_init() {
        let vm = createViewModel()
        XCTAssertTrue(getRepoUseCase.callArgs.isEmpty)
        XCTAssertNil(vm.state.repo)
    }
    
    func test_fetch() {
        let vm = createViewModel()
        let repoResponse = Repo.stub()
        getRepoUseCase.publisher = Result.Publisher(repoResponse).eraseToAnyPublisher()

        vm.send(action: .fetch)
        XCTAssertEqual(getRepoUseCase.callArgs, [.perform(ownerRepo: Event.stub()[0].repo.name)])
        XCTAssertEqual(vm.state.repo, repoResponse)
    }
}

// MARK: - RepositoryViewModelTest

private extension RepositoryViewModelTests {
    func createViewModel(argument: RepositoryViewModel.Argument = .stub()) -> RepositoryViewModel {
        .init(argument: argument, dependency: dependency)
    }
}

// MARK: - RepositoryViewModelTest.Argument

private extension RepositoryViewModel.Argument {
    static func stub() -> Self {
        .init(event: Event.stub()[0])
    }
}
