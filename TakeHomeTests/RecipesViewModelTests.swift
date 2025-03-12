//
//  RecipesViewModelTests.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import XCTest
@testable import TakeHome

@MainActor
final class RecipesViewModelTests: XCTestCase {
    var viewModel: RecipesViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        viewModel = RecipesViewModel()
    }
    
    override func tearDown() async throws {
        viewModel = nil
        try await super.tearDown()
    }
    
    func testFetchRecipesSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch recipes")
        
        await viewModel.fetchRecipes()
        
        XCTAssertFalse(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.recipes.count, 63)
        
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testRecipesDecoding() async throws {
        let jsonString = """
        {
            "recipes": [
                {
                    "uuid": "1234",
                    "name": "Test Recipe",
                    "cuisine": "Test Cuisine",
                    "photo_url_large": "https://abc.com/photo.jpg",
                    "photo_url_small": "https://abc.com/photo-small.jpg",
                    "source_url": "https://abc.com/recipe",
                    "youtube_url": "https://youtube.com/watch"
                }
            ]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: jsonData)
        let recipe = recipeResponse.recipes[0]
        
        XCTAssertEqual(recipe.id, "1234")
        XCTAssertEqual(recipe.name, "Test Recipe")
        XCTAssertEqual(recipe.cuisine, "Test Cuisine")
        XCTAssertEqual(recipe.photoUrlLarge, "https://abc.com/photo.jpg")
        XCTAssertEqual(recipe.photoUrlSmall, "https://abc.com/photo-small.jpg")
        XCTAssertEqual(recipe.sourceUrl, "https://abc.com/recipe")
        XCTAssertEqual(recipe.youtubeUrl, "https://youtube.com/watch")
    }
}
