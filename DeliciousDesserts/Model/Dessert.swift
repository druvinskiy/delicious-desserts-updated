//
//  Dessert.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import Foundation

/// Expected payload:
///
/// ```json
/// {
/// "meals": [
///  {
///   "strMeal": "Apam balik",
///   "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
///   "idMeal": "53049"
///  },
///  {
///   "strMeal": "Apple & Blackberry Crumble",
///   "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
///   "idMeal": "52893"
///  }
/// ]
///}
/// ```
struct DessertResponse: Decodable {
    let meals: [Dessert]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meals = try values.decode([WebDessert].self, forKey: .meals).compactMap({ Dessert(webDessert: $0) })
    }
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

/// Expected payload:
///
/// ```json
/// "meals": [
///  {
///   "strMeal": "Apam balik",
///   "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
///   "idMeal": "53049"
///  },
///  {
///   "strMeal": "Apple & Blackberry Crumble",
///   "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
///   "idMeal": "52893"
///  }
/// ]
/// ```
struct WebDessert: Decodable {
    let name: String?
    let thumbnailUrl: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
        case id = "idMeal"
    }
}

/// Converts a `WebDessert` to a `Dessert`. If the passed `WebDessert` contains a nil `name` or `id`, the `WebDessert` is considered invalid, and a `Dessert` is not created.
struct Dessert: Comparable {
    let name: String
    let thumbnailUrl: String?
    let id: String
    
    init?(webDessert: WebDessert) {
        guard let name = webDessert.name, let id = webDessert.id else {
            return nil
        }
        
        self.name = name
        self.thumbnailUrl = webDessert.thumbnailUrl
        self.id = id
    }
    
    static func < (lhs: Dessert, rhs: Dessert) -> Bool {
        return lhs.name < rhs.name
    }
}
