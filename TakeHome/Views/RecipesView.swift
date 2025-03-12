//
//  RecipesView.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.recipes.isEmpty {
                    EmptyView(
                        icon: viewModel.error != nil ? "exclamationmark.triangle" : "list.bullet",
                        title: viewModel.error != nil ? "Error" : "No Recipes",
                        message: viewModel.error?.localizedDescription,
                        buttonTitle: "Try Again",
                        onClick: {
                            Task {
                                await viewModel.fetchRecipes()
                            }
                        }
                    )
                } else {
                    recipesList
                }
            }
            .navigationTitle("Recipes")
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
    
    private var recipesList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.recipes) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .padding()
        }
    }
}
