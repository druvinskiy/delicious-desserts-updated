//
//  Endpoint.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import Foundation

enum Endpoint {
    case meals(category: String)
    case details(id: String)
    
    var url: URL? {
        switch self {
        case .meals(let category):
            return makeForEndpoint("filter.php?c=\(category)")
        case .details(let id):
            return makeForEndpoint("lookup.php?i=\(id)")
        }
    }
    
    private func makeForEndpoint(_ endpoint: String) -> URL? {
        URL(string: "https://www.themealdb.com/api/json/v1/1/\(endpoint)")
    }
}
