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
