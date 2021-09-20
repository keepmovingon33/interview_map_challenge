//
//  LocationService.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import Foundation

protocol LocationServiceProtocol : class {
    func fetchLocations(_ completion: @escaping ((Result<[Location], ErrorResult>) -> Void))
}

final class FileDataService : LocationServiceProtocol {
    static let shared = FileDataService()
    
    func fetchLocations(_ completion: @escaping ((Result<[Location], ErrorResult>) -> Void)) {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "locations") else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let locations = try decoder.decode([Location].self, from: data)
            completion(.success(locations))
        } catch {
            completion(.failure(ErrorResult.parser(string: "Unable to parse conversion rate")))
        }
    }
}
