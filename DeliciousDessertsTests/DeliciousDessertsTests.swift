//
//  DeliciousDessertsTests.swift
//  DeliciousDessertsTests
//
//  Created by David Ruvinskiy on 6/5/23.
//

import XCTest
@testable import DeliciousDesserts

final class DeliciousDessertsTests: XCTestCase {
    
    func testDessertResponseDecoding() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Chocolate Cake",
                    "strMealThumb": "https://example.com/chocolate_cake.jpg",
                    "idMeal": "1"
                },
                {
                    "strMeal": "Strawberry Cheesecake",
                    "strMealThumb": "https://example.com/strawberry_cheesecake.jpg",
                    "idMeal": "2"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(DessertResponse.self, from: data)
        
        XCTAssertEqual(response.meals.count, 2)
        XCTAssertEqual(response.meals[0].name, "Chocolate Cake")
        XCTAssertEqual(response.meals[0].thumbnailUrl, "https://example.com/chocolate_cake.jpg")
        XCTAssertEqual(response.meals[0].id, "1")
        XCTAssertEqual(response.meals[1].name, "Strawberry Cheesecake")
        XCTAssertEqual(response.meals[1].thumbnailUrl, "https://example.com/strawberry_cheesecake.jpg")
        XCTAssertEqual(response.meals[1].id, "2")
    }
    
    func testDessertComparison() {
        let webDessert1 = WebDessert(name: "Chocolate Cake", thumbnailUrl: "https://example.com/chocolate_cake.jpg", id: "1")
        let webDessert2 = WebDessert(name: "Strawberry Cheesecake", thumbnailUrl: "https://example.com/strawberry_cheesecake.jpg", id: "2")
        
        let dessert1 = Dessert(webDessert: webDessert1)!
        let dessert2 = Dessert(webDessert: webDessert2)!
        
        XCTAssertTrue(dessert1 < dessert2)
        XCTAssertFalse(dessert2 < dessert1)
    }
    
    func testDessertInitializationFromWebDessert() {
        let webDessert = WebDessert(name: "Chocolate Cake", thumbnailUrl: "https://example.com/chocolate_cake.jpg", id: "1")
        let dessert = Dessert(webDessert: webDessert)
        
        XCTAssertEqual(dessert?.name, "Chocolate Cake")
        XCTAssertEqual(dessert?.thumbnailUrl, "https://example.com/chocolate_cake.jpg")
        XCTAssertEqual(dessert?.id, "1")
    }
    
    func testDessertInitializationFromWebDessertWithMissingValues() {
        let webDessert = WebDessert(name: nil, thumbnailUrl: nil, id: nil)
        let dessert = Dessert(webDessert: webDessert)
        
        XCTAssertNil(dessert)
    }
    
    func testDessertResponseDecodingWithMissingId() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Chocolate Cake",
                    "strMealThumb": "https://example.com/chocolate_cake.jpg",
                    "idMeal": "1"
                },
                {
                    "strMeal": "Strawberry Cheesecake",
                    "strMealThumb": "https://example.com/strawberry_cheesecake.jpg"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(DessertResponse.self, from: data)
        
        XCTAssertEqual(response.meals.count, 1)
        XCTAssertEqual(response.meals[0].name, "Chocolate Cake")
        XCTAssertEqual(response.meals[0].thumbnailUrl, "https://example.com/chocolate_cake.jpg")
        XCTAssertEqual(response.meals[0].id, "1")
    }
    
    func testDessertResponseDecodingWithMissingName() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Chocolate Cake",
                    "strMealThumb": "https://example.com/chocolate_cake.jpg",
                    "idMeal": "1"
                },
                {
                    "strMealThumb": "https://example.com/strawberry_cheesecake.jpg",
                    "idMeal": "2"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(DessertResponse.self, from: data)
        
        XCTAssertEqual(response.meals.count, 1)
        XCTAssertEqual(response.meals[0].name, "Chocolate Cake")
        XCTAssertEqual(response.meals[0].thumbnailUrl, "https://example.com/chocolate_cake.jpg")
        XCTAssertEqual(response.meals[0].id, "1")
    }
    
    func testDessertResponseDecodingWithMissingIdAndName() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Chocolate Cake",
                    "strMealThumb": "https://example.com/chocolate_cake.jpg",
                    "idMeal": "1"
                },
                {
                    "strMealThumb": "https://example.com/strawberry_cheesecake.jpg"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(DessertResponse.self, from: data)
        
        XCTAssertEqual(response.meals.count, 1)
        XCTAssertEqual(response.meals[0].name, "Chocolate Cake")
        XCTAssertEqual(response.meals[0].thumbnailUrl, "https://example.com/chocolate_cake.jpg")
        XCTAssertEqual(response.meals[0].id, "1")
    }
}
