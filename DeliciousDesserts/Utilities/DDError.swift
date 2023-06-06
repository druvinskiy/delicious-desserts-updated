//
//  DDError.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import Foundation

enum DDError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case defaultError
    
    var description: String {
        switch self {
        case .invalidURL:
            return String(localized: "invalidURL")
        case .invalidResponse:
            return String(localized: "invalidResponse")
        case .invalidData:
            return String(localized: "invalidData")
        case .defaultError:
            return String(localized: "defaultError")
        }
    }
}
