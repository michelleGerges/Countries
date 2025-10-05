//
//  DIContainerTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
final class DIContainerAppTests: XCTestCase {
    let container = DIContainer()
    
    func testRegisterAndResolveClass() {
        container.register(String.self) { "String" }
        let resolved = container.resolve(String.self)
        XCTAssertEqual(resolved, "String")
    }
    
    func testRegisterAndResolveProtocol() {
        protocol MockProtocol { }
        class MockImp: MockProtocol { }
        container.register(MockProtocol.self) { MockImp() }
        let resolved = container.resolve(MockProtocol.self)
        XCTAssertNotNil(resolved)
    }
}
