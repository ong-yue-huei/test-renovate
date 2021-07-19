//
//  MainViewModelTests.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training
import XCTest

class MainViewModelTests: XCTestCase {
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
    
    func test_fetch() {
        let vm = createViewModel()
        let eventResponse = Event.stub()
        getEventsUseCase.publisher = Result.Publisher(eventResponse).eraseToAnyPublisher()

        vm.send(action: .fetch)
        XCTAssertEqual(getEventsUseCase.callArgs, [.perform(page: 1)])
        XCTAssertEqual(
            vm.state.sections,
            [
                .init(
                    type: .events,
                    cells: [eventResponse[0]]
                )
            ]
        )
    }
}

// MARK: - MainViewModelTest

private extension MainViewModelTests {
    func createViewModel() -> MainViewModel {
        .init(dependency: dependency)
    }
}
