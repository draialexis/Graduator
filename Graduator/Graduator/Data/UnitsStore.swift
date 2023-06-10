//
//  UnitsStore.swift
//  Graduator
//
//  Created by etudiant on 2023-06-10.
//

import SwiftUI


class UnitsStore: ObservableObject {
        
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("dat.data.tho")
    }
    
    func load<T: Codable>(defaultValue: [T]) async throws -> [T] {
            
        let task = Task<[T], Error> {
            let fileURL = try Self.fileURL()
            let data = try? Data(contentsOf: fileURL)
            var elements: [T] = defaultValue
            if let validData = data, !validData.isEmpty {
                elements = try JSONDecoder().decode([T].self, from: validData)
            }
            return elements
        }
        
        return try await task.value
    }
    
    func save<T: Codable>(elements: [T]) async throws {
        
        let task = Task {
            let data = try JSONEncoder().encode(elements)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
    
}
