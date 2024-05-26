//
//  ForecastDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct ForecastDTO: Codable {
    
    var dt: Int!
    var name: String!
    var main: MainDTO!
    var weather: [WeatherDTONew]!
    var sys: SystemDTO!
    var wind: WindDTO!
    var clouds: CloudsDTO!
    
    enum CodingKeys: String, CodingKey {
        case dt
        case name
        case main
        case weather
        case sys
        case wind
        case clouds
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            dt = try? values.decode(Int.self, forKey: .dt)
            name = try? values.decode(String.self, forKey: .name)
            main = try? values.decode(MainDTO.self, forKey: .main)
            weather = try? values.decode([WeatherDTONew].self, forKey: .weather)
            sys = try? values.decode(SystemDTO.self, forKey: .sys)
            wind = try? values.decode(WindDTO.self, forKey: .wind)
            clouds = try? values.decode(CloudsDTO.self, forKey: .clouds)
        }
    }
}
