//
//  CloudsDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct CloudsDTO: Codable {
    
    var cloud: Int!

    enum CodingKeys: String, CodingKey {
        case cloud = "all"
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            cloud = try? values.decode(Int.self, forKey: .cloud)
        }
    }
}
