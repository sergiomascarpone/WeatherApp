//
//  SystemDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct SystemDTO: Codable {
    
    var country: String!
    
    enum CodingKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            country = try? values.decode(String.self, forKey: .country)
        }
    }
}
