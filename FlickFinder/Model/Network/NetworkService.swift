//
//  NetworkService.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation
import OSLog

protocol NetworkService {
    
    func performDataTask<ModelObject: Decodable>(
        on endpoint: Endpoint
    ) async throws -> ModelObject?
    
    func performDataTask(on url: URL?) async throws -> Data?
    
}

final class DefaultNetworkService: NetworkService {
    
    func isStatusCodeOK(for urlResponse: URLResponse) -> Bool {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            return false
        }
        
        guard (200...300).contains(httpURLResponse.statusCode) else {
            Logger().debug("\("Network Error Status Code: \(httpURLResponse.statusCode)")")
            return false
        }
        
        return true
    }
    
    func performDataTask(on url: URL?) async throws -> Data? {
        guard let url = url else {
            return nil
        }
        
        let result = try await URLSession.shared.data(from: url)

        guard isStatusCodeOK(for: result.1) else {
            return nil
        }
     
        return result.0
    }
    
    func performDataTask<ModelObject: Decodable>(
        on endpoint: Endpoint
    ) async throws -> ModelObject? {
        guard let url = endpoint.url else {
            return nil
        }
        
        let result = try await URLSession.shared.data(from: url)
        
        guard isStatusCodeOK(for: result.1) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(ModelObject.self, from: result.0)
        }
        catch let decodingError as DecodingError {
            Logger().debug("\("JSON Decoding Error:\n\(decodingError)")")
            return nil
        }
        catch {
            Logger().debug("\(error.localizedDescription)")
            return nil
        }
    }
    
}
