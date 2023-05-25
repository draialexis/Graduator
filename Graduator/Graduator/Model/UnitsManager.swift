//
//  UnitsManager.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct UnitsManager {
    
    var units: [Unit]

    init(units: [Unit]) {
        self.units = units
    }
    
    func getUnits() -> [Unit] {
        return units
    }
    
    func getUnit(id: UUID) -> Unit? {
        if let index = getIndex(id: id) {
            return units[index]
        } else {
            return nil
        }
    }

    mutating func addUnit(unit: Unit) -> Unit {
        units.append(unit)
        return unit
    }

    mutating func updateUnit(id: UUID, unit: Unit) -> Unit? {
        if let index = getIndex(id: id) {
            units[index] = unit
            return unit
        } else {
            return nil
        }
    }

    mutating func removeUnit(id: UUID) {
        if let index = getIndex(id: id) {
            units.remove(at: index)
        }
    }
    
    private func getIndex(id: UUID) -> Int? {
        return units.firstIndex(where: { $0.id == id })
    }
}
