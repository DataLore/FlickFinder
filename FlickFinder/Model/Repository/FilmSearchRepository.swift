//
//  FilmSearchRepository.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation
import OSLog

protocol FilmSearchRepository: AnyObject {
    
    func fetchPoster(
        with url: URL?
    ) async -> Data?
    
    func search(
        title: String,
        for year: String?
    ) async -> Film?
    
}

class DefaultFilmSearchRepository: FilmSearchRepository {
    
    let networkService: NetworkService = DefaultNetworkService()
    
    func fetchPoster(
        with url: URL?
    ) async -> Data? {
        do {
            return try await networkService.performDataTask(on: url)
        }
        catch {
            Logger().debug("Network service failed while fetching poster data")
            return nil
        }
    }

    func search(
        title: String,
        for year: String?
    ) async -> Film? {
        do {
            let endPoint = FilmSearchEndpoint(title: title, year: year)
            return try await networkService.performDataTask(on: endPoint)
        }
        catch {
            Logger().debug("Network service failed during film search")
            return nil
        }
    }
    
}
