//
//  Location.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import Foundation

struct Location: Decodable {
    let storeNo: Int
    let storeName: String
    let city: String
    let state: String
    let address: String
    let zipCode: String
    let country: String
    let phone: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case storeNo = "StoreNo"
        case storeName = "StoreName"
        case city = "City"
        case state = "State"
        case address = "Address"
        case zipCode = "ZipCode"
        case country = "Country"
        case phone = "Phone"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeNo = try values.decodeIfPresent(Int.self, forKey: .storeNo)!
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)!
        city = try values.decodeIfPresent(String.self, forKey: .city)!
        state = try values.decodeIfPresent(String.self, forKey: .state)!
        address = try values.decodeIfPresent(String.self, forKey: .address)!
        zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)!
        country = try values.decodeIfPresent(String.self, forKey: .country)!
        phone = try values.decodeIfPresent(String.self, forKey: .phone)!
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)!
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)!
    }
    
    var title: String {
        return "\(storeName). No: \(storeNo)"
    }
    
    var fullAddress: String {
        return "\(address), \(state), \(city), \(zipCode), \(country)"
    }
}
