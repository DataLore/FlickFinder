//
//  FilmSearchViewState.swift
//  FlickFinder
//
//  Created by Phil Pepper on 03/03/2021.
//

import Foundation

struct FilmSearchViewState {
    
    let actors: String?
    let director: String?
    let genre: String?
    let language: String?
    let plot: String?
    let poster: Data?
    let rated: String?
    let released: String?
    let runtime: String?
    let title: String?
    let year: String?
    
    init(
        actors: String? = nil,
        director: String? = nil,
        genre: String? = nil,
        language: String? = nil,
        plot: String? = nil,
        poster: Data? = nil,
        rated: String? = nil,
        released: String? = nil,
        runtime: String? = nil,
        title: String? = nil,
        year: String? = nil
    ) {
        self.actors = actors
        self.director = director
        self.genre = genre
        self.language = language
        self.plot = plot
        self.poster = poster
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.title = title
        self.year = year
    }
    
}

extension FilmSearchViewState {
    
    init?(film: Film?, posterData: Data?) {
        guard let film = film else {
            return nil
        }
        
        self.init(
            actors: film.actors,
            director: film.director,
            genre: film.genre,
            language: film.language,
            plot: film.plot,
            poster: posterData,
            rated: film.rated,
            released: film.released,
            runtime: film.runtime,
            title: film.title,
            year: film.year
        )
    }
    
}
