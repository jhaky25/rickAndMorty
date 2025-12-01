//
//  ListCharactersViewModelTests.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import XCTest
import Combine
@testable import rickAndMorty

final class ListCharactersViewModelTests: XCTestCase {

    private var charactersViewModel: listCharactersViewModel!
    private var repository: MockCharacterRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        repository = MockCharacterRepository()
        charactersViewModel = listCharactersViewModel(repository: repository)
        cancellables = []
    }

    override func tearDown() {
        charactersViewModel = nil
        repository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadCharactersSuccess() {
        
        let expected = [
            characterModel(
                id: 1,
                name: "Esponja",
                status: "",
                species: "Marino",
                image: "",
                gender: "",
                location: locationModel(name: ""),
                episode: ["1", "2"]
            )
        ]

        repository.result = .success(expected)

        let expectation = XCTestExpectation(description: "Characters loaded")

        var received: [[characterModel]] = []

        charactersViewModel.charactersPublisher
            .dropFirst()
            .sink { value in
                received.append(value)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        charactersViewModel.loadCharacters()

        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(received.first?.count, 1)
        XCTAssertEqual(repository.receivedPage, 1)
    }
    
    func testIsLoadingChanges() {
        
        repository.result = .success([])

        let expectation = XCTestExpectation(description: "Loading changes")

        var loadingStates: [Bool] = []

        charactersViewModel.isLoadingPublisher
            .sink { value in
                loadingStates.append(value)

                if loadingStates.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        charactersViewModel.loadCharacters()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(loadingStates, [false, true, false])
    }
    
    func testIsLoadingState() {
        
        repository.result = .success([])

        let expectation = XCTestExpectation(description: "Loading state")

        var states: [Bool] = []

        charactersViewModel.$isLoading
            .sink { value in
                states.append(value)
                if states.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        charactersViewModel.loadCharacters()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(states, [false, true, false])
    }
    
    func testInitialStateEmptyCharacters() {
        XCTAssertTrue(charactersViewModel.characters.isEmpty)
    }
}
