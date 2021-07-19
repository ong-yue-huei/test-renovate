//
//  UserViewModelTests.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training
import XCTest

class UserViewModelTests: XCTestCase {
    private var getUserUseCase = GetUserUseCaseMock()
    private var getUserReposUseCase = GetUserReposUseCaseMock()
    private lazy var dependency = UserViewModel.Dependency(
        getUserUseCase: getUserUseCase,
        getUserReposUseCase: getUserReposUseCase
    )
   
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_init() {
        let vm = createViewModel()
        XCTAssertTrue(getUserUseCase.callArgs.isEmpty)
        XCTAssertTrue(getUserReposUseCase.callArgs.isEmpty)
        XCTAssertTrue(vm.state.sections.isEmpty)
        XCTAssertNil(vm.state.user)
    }
}

// MARK: - UserViewModelTests

private extension UserViewModelTests {
    func createViewModel(argument: UserViewModel.Argument = .stub()) -> UserViewModel {
        .init(argument: argument, dependency: dependency)
    }
}

// MARK: - UserViewModelTests.Argument

private extension UserViewModel.Argument {
    static func stub() -> Self {
        .init(username: Event.stub()[0].actor.login)
    }
}
