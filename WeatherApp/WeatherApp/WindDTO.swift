//
//  WindDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct WindDTO: Codable {
    
    var speed: Double!
    var windDirection: Int!
    
    enum CodingKeys: String, CodingKey {
        case speed
        case windDirection = "deg"
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            speed = try? values.decode(Double.self, forKey: .speed)
            windDirection = try? values.decode(Int.self, forKey: .windDirection)
        }
    }
}
