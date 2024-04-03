//
//  MainDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct MainDTO: Codable {
    
    var temp: Double!
    var pressure: Int!
    var humidity: Int!
     
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            temp = try? values.decode(Double.self, forKey: .temp)
            pressure = try? values.decode(Int.self, forKey: .pressure)
            humidity = try? values.decode(Int.self, forKey: .humidity)
        }
    }
}
