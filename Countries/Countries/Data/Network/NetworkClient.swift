//
//  NetworkClient.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

protocol NetworkClient {
    func request<T: Codable>(_ endPoint: EndPoint) async throws -> T
}

class NetworkClientImplementation: NetworkClient {
    
    @Dependency private var urlSession: URLSessionProtocol
    
    static var shared: NetworkClient = {
        NetworkClientImplementation()
    }()
    
    func request<T: Codable>(_ endPoint: EndPoint) async throws -> T {
        
        guard let url = endPoint.fullURL else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await urlSession.data(for: URLRequest(url: url))
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serialization
            }
            if httpResponse.statusCode == Constants.Network.SUCCESS_RESPONSE_CODE {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                let error = try JSONDecoder().decode(ServerError.self, from: data)
                throw NetworkError.server(error: error)
            }
        } catch _ as URLError {
            throw NetworkError.connectivity
        } catch _ as DecodingError {
            throw NetworkError.serialization
        } catch {
            throw (error as? NetworkError) ?? NetworkError.unknown
        }
    }
}
