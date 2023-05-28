//
//  UnitsManager.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct UnitsManager {
    
    var units: [Unit]
    
    func getTotalAverage() -> Double? {
        return getAverage(units: units)
    }
    
    func getProfessionalAverage() -> Double? {
        return getAverage(units: units.filter { $0.isProfessional })
    }
    
    func getAverage(units: [Unit]) -> Double? {
        var totalWeight = 0
        var weightedSum = 0.0

        for unit in units {
            if let grade = unit.getAverage() {
                totalWeight += unit.weight
                weightedSum += grade * Double(unit.weight)
            }
        }
        
        guard totalWeight > 0 else { return nil }
        
        return weightedSum / Double(totalWeight)
    }
}
