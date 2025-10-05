//
//  NetworkError.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

enum NetworkError: Error {
    case connectivity
    case invalidURL
    case unknown
    case serialization
    case server(error: ServerError)
}

struct ServerError: Codable {
    
    let status: Int
    let message: String
}

extension Error {
    
    private var generalErrorMessage: String {
        "Something went wrong. Kindly try again later!"
    }
    
    var message: String {
        guard let errorHandler = self as? NetworkError else {
            return generalErrorMessage
        }
        
        switch errorHandler {
        case .connectivity:
            return "Network Error, Kindly check Internet connectivity!"
        case .server(let error):
            return error.message
        default:
            return generalErrorMessage
        }
    }
}
