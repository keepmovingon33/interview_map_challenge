//
//  ErrorResult.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
