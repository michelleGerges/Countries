//
//  ContentState.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

enum ContentState<Content> {
    case idle
    case loading
    case completed(Content)
    case error(Error)
    
    var loading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var completed: Bool {
        switch self {
        case .completed:
            return true
        default:
            return false
        }
    }
    
    var data: Content? {
        switch self {
        case .completed(let data):
            return data
        default:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
