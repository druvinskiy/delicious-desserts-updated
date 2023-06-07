//
//  DessertDetail.swift
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
///   "strInstructions": "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.",
///   "strIngredient1": "Milk",
///   "strIngredient2": "Oil",
///   "strIngredient1": "Eggs",
///   "strMeasure1": "200ml"
///   "strMeasure2": "60ml"
///   "strMeasure3": "2",
///  }
/// ]
///}
/// ```
struct DetailsResponse: Decodable {
    let detailsArray: [DessertDetail]
    
    enum CodingKeys: String, CodingKey {
        case detailsArray = "meals"
    }
}

/// Expected payload:
///
/// ```json
/// {
///  "strInstructions": "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.",
///  "strIngredient1": "Milk",
///  "strIngredient2": "Oil",
///  "strIngredient1": "Eggs",
///  "strMeasure1": "200ml"
///  "strMeasure2": "60ml"
///  "strMeasure3": "2",
/// }
/// ```
///
/// The JSON will contain other properties, but they are not needed.
struct DessertDetail: Decodable {
    let instructions: String
    let ingredients: [Ingredient]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String: String?].self)
        
        guard let instructions = dict["strInstructions"] as? String else {
            throw DDError.invalidData
        }
        
        self.instructions = instructions
        self.ingredients = try DessertDetail.parseIngredients(from: dict)
    }
    
    /// Ingredients and measurements for a meal are represented by a parallel set of fields in the JSON
    /// named "strIngredient1", "strIngredient2", "strIngredient3" and "strMeasure1", "strMeasure2", "strMeasure1".
    /// "strIngredient1" needs to be connected to "strMeasure1",  "strIngredient2" needs to be connected to "strMeasure2", etc.
    ///
    /// If an ingredient does not have a corresponding measurement, an error is thrown.
    ///
    /// - Parameter dict: The dictionary containing ingredients, measurements, and other details about a meal.
    /// - Returns: An ``[Ingredient]`` containing the connected ingredients and measurements.
    private static func parseIngredients(from dict: [String: String?]) throws -> [Ingredient] {
        var ingredients = [Ingredient]()
        
        for (key, value) in dict {
            guard key.starts(with: "strIngredient"),
                  let value = value, !value.isEmpty,
                  let range = key.range(of: "strIngredient") else {
                
                continue
            }
            
            let ingredientNumber = key[range.upperBound...]
            
            guard let ingredientMeasure = dict["strMeasure\(ingredientNumber)"] as? String else {
                throw DDError.invalidData
            }
            
            let normalizedIngredientName = value.lowercased().trimmingCharacters(in: .whitespaces)
            let normalizedIngredientMeasure = ingredientMeasure.trimmingCharacters(in: .whitespaces)
            
            let ingredient = Ingredient(name: normalizedIngredientName, measurement: normalizedIngredientMeasure)
            ingredients.append(ingredient)
        }
        
        return ingredients
    }
}

struct Ingredient {
    let name: String
    let measurement: String
}
