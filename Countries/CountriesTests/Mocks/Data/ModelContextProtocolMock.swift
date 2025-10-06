//
//  ModelContextProtocolMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 06/10/2025.
//

import Foundation
@testable import Countries
import SwiftData

final class ModelContextProtocolMock: ModelContextProtocol {
    var nextFetchResult: [Any] = []
    var insertCalled = false
    var saveCalled = false
    var deleteCalled = false

    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
        return nextFetchResult as? [T] ?? []
    }

    func insert<T>(_ model: T) where T : PersistentModel {
        insertCalled = true
    }

    func save() throws {
        saveCalled = true
    }

    func delete<T>(_ model: T) where T : PersistentModel {
        deleteCalled = true
    }
}
