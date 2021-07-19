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
    
    func test_fetch() {
        let vm = createViewModel()
        let userResponse = User.stub()
        let userReposResponse = [Repo.stub(id: 1), Repo.stub(id: 2)]
        getUserUseCase.publisher = Result.Publisher(userResponse).eraseToAnyPublisher()
        getUserReposUseCase.publisher = Result.Publisher(userReposResponse).eraseToAnyPublisher()
        
        vm.send(action: .fetch)
        XCTAssertEqual(getUserUseCase.callArgs, [.perform(username: Event.stub()[0].actor.login)])
        XCTAssertEqual(getUserReposUseCase.callArgs, [.perform(username: Event.stub()[0].actor.login)])
        XCTAssertEqual(vm.state.user, userResponse)
        XCTAssertEqual(
            vm.state.sections,
            [
                .init(
                    type: .events,
                    cells: userReposResponse
                )
            ]
        )
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
