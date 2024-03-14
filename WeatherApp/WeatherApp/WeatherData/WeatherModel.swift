//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.
//

import Foundation

//func downloadWeatherDetails(completed: @escaping downlaodComplete) {
//       //Alamofire downlaod
//       Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
//           let result = response.result
//           if let dict = result.value as? Dictionary<String, AnyObject> {
//               if let name = dict["name"] as? String {
//                   self._cityName = name.capitalized
//                   print(self._cityName)
//                   print(self.cityName)
//               }
//               if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
//                   if let main = weather[0]["main"] as? String {
//                       self._weatherType = main.capitalized
//                       print(self._weatherType)
//                       print(self.weatherType)
//                   }
//               }
//               if let main = dict["main"] as? Dictionary<String, AnyObject> {
//                   if let currentTemperature = main["temp"] as? Double {
//                       let kelvinToCelsiusPreDivison = currentTemperature - 273.15 //Converting Kelvin to Celsius.
//                       let kelvinToCelsius = Double(round(10*kelvinToCelsiusPreDivison/10)) //rounds up the Double to 1 Decimal Point.
//                       self._currentTemp = kelvinToCelsius
//                   }
//               }
//           }
//           completed()
//       }
//   }
//}
