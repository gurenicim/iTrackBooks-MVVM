//
//  Extentions.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let savedBooks = "savedBooks"
    }
    
    func saveBooks(_ books: [Book]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(books) {
            set(encoded, forKey: Keys.savedBooks)
        }
    }
    
    func loadBooks() -> [Book] {
        if let savedBooks = data(forKey: Keys.savedBooks) {
            let decoder = JSONDecoder()
            if let loadedBooks = try? decoder.decode([Book].self, from: savedBooks) {
                return loadedBooks
            }
        }
        return []
    }
}

extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension Data {
    func decodedObject<T: Decodable>() throws -> T {
        try JSONDecoder.shared.decode(T.self, from: self)
    }
}
