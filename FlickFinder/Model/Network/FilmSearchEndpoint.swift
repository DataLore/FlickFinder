//
//  FilmSearchEndpoint.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation

struct FilmSearchEndpoint: Endpoint {
    
    let title: String
    let year: String?
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.omdbapi.com"
        components.queryItems = queryItems
        return components.url
    }
    
    private var queryItems: [URLQueryItem] {
        guard let apiKeyQueryItem = apiKeyQueryItem else {
            return [URLQueryItem]()
        }
        
        var queryItems = [apiKeyQueryItem]
        queryItems.append(
            URLQueryItem(name: "t", value: title)
        )
        
        if let year = year, !year.isEmpty {
            queryItems.append(
                URLQueryItem(name: "y", value: "\(year)")
            )
        }
        
        return queryItems
    }
    
}
