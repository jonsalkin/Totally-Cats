//
//  CatViewViewModel.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/22/23.
//

import Foundation

class CatImageManager: ObservableObject {
    func getCatImage() async throws -> [CatImage] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?api_key=live_MEOLSbhVQenZogGJjRFOQL88ASdOSpJGnjil1KJzPnytU293zR7aJsicdoxQSJQv") else { fatalError("Missing URL ") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching cat image data") }
        
        let decodedData = try JSONDecoder().decode([CatImage].self, from: data)
                
        print("Decoded CatResponse: \(decodedData)")
        
        
        return decodedData
    }
}

struct CatResponse: Decodable {
    var images: [CatImage]
}

struct CatImage: Decodable {
    var id: String
    var url: String
}


