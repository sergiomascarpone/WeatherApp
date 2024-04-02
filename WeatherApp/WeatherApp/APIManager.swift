//
//  APIManager.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation
import Alamofire

// MARK: - URLRequestConvertible
extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let completeUrl = baseURL.appending(path)
        let urlWithoutPercent = completeUrl.removingPercentEncoding
        let finalUrl = URL(string: urlWithoutPercent!)
        var request = URLRequest(url: finalUrl!)
        request.method = method
        request = try URLEncoding.default.encode(request, with: params)
        return request
    }
}
