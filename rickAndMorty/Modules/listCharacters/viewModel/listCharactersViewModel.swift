//
//  listCharactersViewModel.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import Foundation
import Combine

final class listCharactersViewModel: ObservableObject {

    // MARK: - Inputs
    @Published var searchName: String? = nil
    @Published var filterStatus: String? = nil
    @Published var filterSpecies: String? = nil

    // MARK: - Outputs
    @Published private(set) var characters: [characterModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isEmpty: Bool = false
    @Published private(set) var errorMessage: String?

    // MARK: - Private
    private var currentPage = 1
    private var canLoadMore = true
    private var subscriptions = Set<AnyCancellable>()
    private let repository: CharacterRepositoryProtocol

    // MARK: - Init
    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
        
        Publishers.CombineLatest3($searchName, $filterStatus, $filterSpecies)
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] _, _, _ in
                self?.loadCharacters(reset: true)
            }
            .store(in: &subscriptions)
    }

    // MARK: - Public Methods
    func loadCharacters(reset: Bool = false) {
        guard !isLoading else { return }

        if reset {
            currentPage = 1
            canLoadMore = true
            characters = []
        }
        guard canLoadMore else { return }

        isLoading = true
        errorMessage = nil

        repository.fetchCharacters(page: currentPage,
                                   name: searchName,
                                   status: filterStatus,
                                   species: filterSpecies)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.isEmpty = self.characters.isEmpty
                }
            } receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                self.characters.append(contentsOf: newCharacters)
                self.isEmpty = self.characters.isEmpty
                self.currentPage += 1
                self.canLoadMore = !newCharacters.isEmpty
            }
            .store(in: &subscriptions)
    }
    
    var charactersPublisher: AnyPublisher<[characterModel], Never> {
        $characters.eraseToAnyPublisher()
    }

    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }

    var errorMessagePublisher: AnyPublisher<String?, Never> {
        $errorMessage.eraseToAnyPublisher()
    }
}
