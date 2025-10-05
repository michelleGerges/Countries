//
//  EndPoints.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation

enum EndPoint {
    case country(code: String)
}

extension EndPoint {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.Network.BASE_URL) else {
            fatalError("invalid base url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .country(let code):
            "\(Constants.Network.EndPoint.COUNTRY_BY_CODE)/\(code)"
        }
    }
    
    var params: [String: String] {
        switch self {
        case .country:
            ["fields": "name,capital,currencies"]
        }
    }
    
    var fullURL: URL? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
