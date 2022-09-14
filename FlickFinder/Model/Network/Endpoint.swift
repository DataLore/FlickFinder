//
//  Endpoint.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation
import OSLog

protocol Endpoint {
    
    var apiKeyQueryItem: URLQueryItem? { get }
    var url: URL? { get }
    
}

extension Endpoint {
    
    var apiKeyQueryItem: URLQueryItem? {
        guard let path = Bundle.main.url(
            forResource: "APIKey",
            withExtension: "plist"
        )
        else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: path)
            let apiSecret = try PropertyListDecoder().decode(Secret.self, from: data)
            return URLQueryItem(name: "apiKey", value: apiSecret.key)
        }
        catch let decodingError as DecodingError {
            Logger().debug("API Secret Decoding Error: \(decodingError.localizedDescription)")
            return nil
        }
        catch {
            Logger().debug("API Secret Error: \(error.localizedDescription)" )
            return nil
        }
    }
    
}
