//
//  Result.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
