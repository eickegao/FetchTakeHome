//
//  RecipeCard.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    @State private var showNoSourceAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = recipe.photoUrlLarge,
               !urlString.isEmpty,
               let url = URL(string: urlString) {
                AsyncImageView(url: url, cornerRadius: 12)
                    .frame(height: 200)
            }
            
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name ?? "Unknown")
                        .foregroundColor(.primary)
                    
                    Text(recipe.cuisine ?? "Unknown")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if let urlString = recipe.youtubeUrl,
                   !urlString.isEmpty,
                   let url = URL(string: urlString) {
                    Button {
                        UIApplication.shared.open(url)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .contentShape(Rectangle())
        .onTapGesture {
            if let urlString = recipe.sourceUrl,
               !urlString.isEmpty,
               let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            } else {
                showNoSourceAlert = true
            }
        }
        .alert("Source Unavailable", isPresented: $showNoSourceAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Sorry, the recipe source is not available.")
        }
    }
}
