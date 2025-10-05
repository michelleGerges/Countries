//
//  NetworkClientTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
final class NetworkClientDataNetworkTests: XCTestCase {
    private var session: URLSessionMock!

    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        DIContainer.shared.register(URLSessionProtocol.self) { self.session }
    }

    func testRequestSuccessDecodesData() async throws {
        let url = URL(string: "https://restcountries.com/v3.1/alpha/EG?fields=name,capital,currencies")!
        let json = """
        {
            "name": {
                "common": "Egypt",
                "official": "Arab Republic of Egypt"
            },
            "currencies": {
                "EGP": {
                    "name": "Egyptian pound"
                }
            },
            "capital": [
                "Cairo"
            ]
        }
        """
        let data = json.data(using: .utf8)!

        session.nextResponse = .init(url: url, statusCode: 200, data: data)

        let client = NetworkClientImplementation()

        let endPoint = EndPoint.country(code: "EG")
        let result: Country = try await client.request(endPoint)
        XCTAssertEqual(result.name.common, "Egypt")
        XCTAssertEqual(result.capital.first, "Cairo")
        XCTAssertEqual(result.currencies["EGP"]?.name, "Egyptian pound")
    }

    func testRequestServerErrorThrowsServerError() async {
        let url = URL(string: "https://restcountries.com/test")!
        let server = ServerError(status: 404, message: "Not found")
        let data = try! JSONEncoder().encode(server)

        session.nextResponse = .init(url: url, statusCode: 404, data: data)

        let client = NetworkClientImplementation()

        let endPoint = EndPoint.country(code: "XX")
        do {
            let _: Country = try await client.request(endPoint)
            XCTFail("Expected to throw")
        } catch let error as NetworkError {
            switch error {
            case .server(let err):
                XCTAssertEqual(err.status, 404)
                XCTAssertEqual(err.message, "Not found")
            default:
                XCTFail("Wrong error")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequestConnectivityErrorThrowsConnectivity() async {
        session.nextError = URLError(.timedOut)

        let client = NetworkClientImplementation()

        let endPoint = EndPoint.country(code: "EG")
        do {
            let _: Country = try await client.request(endPoint)
            XCTFail("Expected to throw")
        } catch let error as NetworkError {
            switch error {
            case .connectivity:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected connectivity error, got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequestDecodingErrorThrowsSerialization() async {
        let url = URL(string: "https://restcountries.com/v3.1/alpha/EG?fields=name,capital,currencies")!
        let invalidJSON = "{ invalid json }".data(using: .utf8)!
        session.nextResponse = .init(url: url, statusCode: 200, data: invalidJSON)

        let client = NetworkClientImplementation()

        let endPoint = EndPoint.country(code: "EG")
        do {
            let _: Country = try await client.request(endPoint)
            XCTFail("Expected to throw")
        } catch let error as NetworkError {
            switch error {
            case .serialization:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected serialization error, got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    
}


