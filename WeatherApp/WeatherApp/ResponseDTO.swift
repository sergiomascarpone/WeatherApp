//
//  ResponceDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation

struct ResponseDTO: Codable {
    
    var cod: Int!
    var message: Int!
    var cnt: Int!
    var forecasts: [ForecastDTO]!
 
    enum CodingKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case forecasts = "list"
    }
    
    init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            cod = try? values.decode(Int.self, forKey: .cod)
            message = try? values.decode(Int.self, forKey: .message)
            cnt = try? values.decode(Int.self, forKey: .cnt)
            forecasts = try? values.decode([ForecastDTO].self, forKey: .forecasts)
        }
    }
}
