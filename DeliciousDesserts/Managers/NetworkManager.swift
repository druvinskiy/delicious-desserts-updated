//
//  NetworkManager.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class NetworkManager {
    private var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchDesserts() async throws -> [Dessert] {
        let endpoint = Endpoint.meals(category: "Dessert").url
        let response: DessertResponse = try await fetch(url: endpoint)
        return response.meals
    }
    
    func fetchDetails(endpoint: URL?) async throws -> DessertDetail {
        let response: DetailsResponse = try await fetch(url: endpoint)
        
        guard let details = response.detailsArray.first else {
            throw DDError.invalidData
        }
        
        return details
    }
    
    func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url = url else {
            throw DDError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DDError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DDError.invalidData
        }
    }
}
