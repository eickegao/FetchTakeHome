//
//  ServiceManager.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Error)
}

actor ServiceManager {
    static let singleton = ServiceManager()
    private init() {}

    private static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: Self.baseURL) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return recipeResponse.recipes
        } catch _ as DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.serverError(error)
        }
    }
}
