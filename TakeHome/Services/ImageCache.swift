//
//  ImageCache.swift
//  TakeHome
//
//  Created by eicke on 3/11/25.
//

import Foundation
import UIKit

actor ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
    private init() {
        cache.countLimit = 100
    }
    
    private var cacheDirectory: URL {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("ImageCache")
    }
    
    private func cacheFileURL(for key: String) -> URL {
        return cacheDirectory.appendingPathComponent(key.replacingOccurrences(of: "/", with: "_"))
    }
    
    func image(for url: URL) async throws -> UIImage? {
        let key = url.absoluteString as NSString
        
        // if exits return
        if let cachedImage = cache.object(forKey: key) {
            return cachedImage
        }
        
        // Check disk before download the image
        let fileURL = cacheFileURL(for: url.absoluteString)
        if fileManager.fileExists(atPath: fileURL.path),
           let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            cache.setObject(image, forKey: key)
            return image
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        cache.setObject(image, forKey: key)
        
        try await saveToDisk(image: image, for: url)
        
        return image
    }
    
    private func saveToDisk(image: UIImage, for url: URL) async throws {
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try fileManager.createDirectory(at: cacheDirectory,
                                         withIntermediateDirectories: true,
                                         attributes: nil)
        }
        
        let fileURL = cacheFileURL(for: url.absoluteString)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        try data.write(to: fileURL)
    }
    
    func clearCache() {
        cache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
    }
}
