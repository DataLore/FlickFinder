//
//  Film.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation

struct Film: Decodable {

    let actors: String?
    let director: String?
    let genre: String?
    let language: String?
    let plot: String?
    let poster: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let title: String?
    let year: String?

    private enum CodingKeys: String, CodingKey {

        case actors = "Actors"
        case director = "Director"
        case genre = "Genre"
        case language = "Language"
        case plot = "Plot"
        case poster = "Poster"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case title = "Title"
        case year = "Year"
        
    }
    
}

