//
//  MainViewModelTest.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training
import XCTest

class MainViewModelTest: XCTestCase {
    private var getEventsUseCase = GetEventsUseCaseMock()
    private lazy var dependency = MainViewModel.Dependency(getEventsUseCase: getEventsUseCase)
   
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_init() {
        let vm = createViewModel()
        XCTAssertTrue(getEventsUseCase.callArgs.isEmpty)
        XCTAssertTrue(vm.state.sections.isEmpty)
    }
    
    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

// MARK: - MainViewModelTest

private extension MainViewModelTest {
    func createViewModel() -> MainViewModel {
        .init(dependency: dependency)
    }
    
    func createEvent() -> [Event] {
        return [Event(
                    id: "",
                    type: "",
                    actor: Event.Actor(
                        id: 0,
                        login: "",
                        displayLogin: "",
                        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/41898282?")!),
                    repo: RepositorySummary(
                        id: 0,
                        name: "",
                        url:URL(string: "https://avatars.githubusercontent.com/u/41898282?")!))]
    }
}
