//
//  URLSessionMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

final class URLSessionMock: URLSessionProtocol, @unchecked Sendable {
    struct Response {
        let url: URL
        let statusCode: Int
        let data: Data
        init(url: URL, statusCode: Int = 200, data: Data) {
            self.url = url
            self.statusCode = statusCode
            self.data = data
        }
    }

    var nextResponse: Response?
    var nextError: Error?

    init() {}

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError { throw error }
        guard let response = nextResponse else { throw URLError(.badServerResponse) }
        let http = HTTPURLResponse(url: response.url, statusCode: response.statusCode, httpVersion: nil, headerFields: nil)!
        return (response.data, http)
    }
}
