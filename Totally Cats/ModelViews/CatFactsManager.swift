//
//  CatFactsManager.swift
//  Totally Cats
//
//  Created by Jon Salkin on 6/23/23.
//

import Foundation

class CatFactsManager: ObservableObject {
    @Published var catFacts: [Facts] = []
    
    func getCatFacts() async throws {
        guard let url = URL(string: "https://catfact.ninja/fact?max_length=140") else {
            fatalError("Missing URL")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(InitialCatFacts.self, from: data)
        
        print("Decoded CatFacts: \(decodedData)")
        
        DispatchQueue.main.async {
            self.catFacts = decodedData.fact
        }
    }
}

struct InitialCatFacts: Codable {
    let fact: [Facts]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let textArray = try? container.decode([Facts].self, forKey: .fact) {
            self.fact = textArray
        } else if let textString = try? container.decode(String.self, forKey: .fact) {
            self.fact = [Facts(fact: textString)]
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fact, in: container, debugDescription: "Invalid data for 'fact' key")
        }
    }
}


struct Facts: Codable, Hashable {
    let fact: String
}
