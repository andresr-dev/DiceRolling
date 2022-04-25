//
//  FileManager.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 25/04/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decode<T:Codable>(from url: URL) throws -> T {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
    }
    
    func save<T:Codable>(_ items: T, to url: URL) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
