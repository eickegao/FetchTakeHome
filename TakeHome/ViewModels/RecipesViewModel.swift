//
//  RecipesViewModel.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var error: Error?
    @Published private(set) var isLoading = false
    
    func fetchRecipes() async {
        isLoading = true
        error = nil
        
        do {
            //try? await Task.sleep(for: .seconds(10)) test loading
            recipes = try await ServiceManager.singleton.fetchRecipes()
        } catch {
            self.error = error
            recipes = []
        }
        
        isLoading = false
    }
}
