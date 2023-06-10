//
//  UnitsManager.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct UnitsManager {
    
    var units: [Unit]
    private var store = UnitsStore()

    public init(units: [Unit] = [], store: UnitsStore = UnitsStore()) {
        self.units = units
        self.store = store
    }
    
    mutating func load() async throws {
        do {
            self.units = try await store.load(defaultValue: Stub.units)
        } catch {
            // DEV: this should be replaced with proper error handling before ever going to prod
            print("ERROR: Failed to load...")
        }
    }
    
    func save() async throws {
        do {
            try await store.save(elements: units)
        } catch {
            // DEV: this should be replaced with proper error handling before ever going to prod
            print("ERROR: Failed to save...")
        }
    }
    
    func getTotalAverage() -> Double? {
        return WeightedAverageCalculator.average(elements: units)
    }
    
    func getProfessionalAverage() -> Double? {
        let professionalUnits = units.filter { $0.isProfessional }
        return WeightedAverageCalculator.average(elements: professionalUnits)
    }
}
