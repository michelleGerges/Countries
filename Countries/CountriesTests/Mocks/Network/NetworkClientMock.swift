//
//  NetworkClientMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

final class NetworkClientMock: NetworkClient {
    var nextData: Data?
    var nextError: Error?

    func request<T: Codable>(_ endPoint: EndPoint) async throws -> T {
        if let error = nextError {
            throw error
        }
        guard let data = nextData else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}



