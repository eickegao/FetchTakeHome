//
//  EmptyView.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import SwiftUI

struct EmptyView: View {
    let icon: String
    let title: String
    let message: String?
    let buttonTitle: String
    let onClick: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(icon == "exclamationmark.triangle" ? .red : .secondary)
            
            Text(title)
                .font(.headline)
            
            if let message = message {
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(buttonTitle) {
                onClick()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
} 
