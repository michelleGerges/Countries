//
//  HomeViewModelTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
class HomeViewModelTests: XCTestCase {
    private var useCase: CountryUseCaseMock!

    override func setUp() {
        super.setUp()
        useCase = CountryUseCaseMock()
        DIContainer.shared.register(CountryUseCase.self) { self.useCase }
    }

    func testLoadCountriesSetsLoadingThenCompleted() async {
        useCase.delayNanoseconds = 2_000_000_000 // 2 seconds
        
        let sut = HomeViewModel()

        XCTAssertFalse(sut.countries.loading)
        let task = Task { await sut.loadCountries() }
        await Task.yield()
        XCTAssertTrue(sut.countries.loading)
        await task.value
        XCTAssertTrue(sut.countries.completed)
        XCTAssertEqual(sut.countries.data?.first?.name.common, "Egypt")
    }

    func testLoadCountriesErrorSetsErrorState() async {
        useCase.delayNanoseconds = 2_000_000_000 // 2 seconds
        useCase.nextError = NetworkError.connectivity
        
        let sut = HomeViewModel()
        let task = Task { await sut.loadCountries() }
        await Task.yield()
        XCTAssertTrue(sut.countries.loading)
        await task.value
        XCTAssertNotNil(sut.countries.error)
        XCTAssertFalse(sut.countries.completed)
    }

    func testHomeScreenTitleIsLocalized()  {
        let sut = HomeViewModel()
        XCTAssertEqual(sut.title, "Home")
    }
}


