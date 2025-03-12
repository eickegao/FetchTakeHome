//
//  AsyncImageView.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let cornerRadius: CGFloat
    
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay {
                        if isLoading {
                            ProgressView()
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        guard let url = url else { return }
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            image = try await ImageCache.shared.image(for: url)
        } catch {
            print("Error loading image: \(error)")
        }
    }
} 
