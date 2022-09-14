//
//  FilmSearchViewModel.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation

protocol FilmSearchViewModel: AnyObject {
    
    var filmSearchViewState: FilmSearchViewState? { get }
    
    func search(title: String, for year: String?)
    
}

final class DefaultFilmSearchViewModel: FilmSearchViewModel {
    
    //MARK: - State
    
    private var film: Film?
    private var posterData: Data?
    private let repository: FilmSearchRepository?
    private weak var scene: FilmSearchScene?

    //MARK: - Lifecycle
    
    init(
        repository: FilmSearchRepository? = nil,
        scene: FilmSearchScene? = nil
    ) {
        self.repository = repository
        self.scene = scene
    }
    
    var filmSearchViewState: FilmSearchViewState? {
        FilmSearchViewState(film: film, posterData: posterData)
    }
    
    func search(title: String, for year: String?) {
        Task {
            guard !title.isEmpty, let film = await repository?.search(title: title, for: year) else {
                DispatchQueue.main.async { [weak scene] in
                    scene?.showNoResultFoundWarning()
                }
                return
            }
            self.film = film
            self.posterData = await fetchPosterData(for: self.film)
            DispatchQueue.main.async { [weak scene] in
                scene?.showUpdatedContent()
            }
        }
    }
    
    private func fetchPosterData(for film: Film?) async -> Data? {
        guard let poster = film?.poster else {
            return nil
        }
        return await repository?.fetchPoster(with: URL(string: poster))
    }
    
}
