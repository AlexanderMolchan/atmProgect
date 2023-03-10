//
//  FilialModel.swift
//  MapBank
//
//  Created by Александр Молчан on 12.01.23.
//

import Foundation

struct AtmInfo: Decodable {
    var latitude: String
    var longitude: String
    var cashIn: String
    var address: String
    var house: String
    var city: String
    var atmError: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "gps_x"
        case longitude = "gps_y"
        case cashIn = "cash_in"
        case address = "address"
        case house = "house"
        case city = "city"
        case atmError = "ATM_error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        cashIn = try container.decode(String.self, forKey: .cashIn)
        address = try container.decode(String.self, forKey: .address)
        house = try container.decode(String.self, forKey: .house)
        city = try container.decode(String.self, forKey: .city)
        atmError = try container.decode(String.self, forKey: .atmError)
    }
}
