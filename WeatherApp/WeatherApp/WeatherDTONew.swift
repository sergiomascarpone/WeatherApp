//
//  WeatherDTONew.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct WeatherDTONew: Codable {
    
    var sky: String!
    var icon: String!
    
    enum CodingKeys: String, CodingKey {
        case sky = "main"
        case icon
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            sky = try? values.decode(String.self, forKey: .sky)
            icon = try? values.decode(String.self, forKey: .icon)
        }
    }
}
