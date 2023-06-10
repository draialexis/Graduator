//
//  UnitsManagerVM.swift
//  Graduator
//
//  Created by etudiant on 2023-05-25.
//

import Foundation

extension UnitsManager {
    struct Data {
        var units: [Unit.Data] = []
    }
    
    var data: Data {
        Data(
            units: self.units.map{ $0.data }
        )
    }
    
    mutating func update(from data: Data) {
        self.units = data.units.map{
            Unit(
                id: $0.id,
                name: $0.name,
                weight: $0.weight,
                isProfessional: $0.isProfessional,
                code: $0.code,
                subjects: $0.subjects.map {
                    Subject(
                        id: $0.id,
                        name: $0.name,
                        weight: $0.weight,
                        grade: $0.grade
                    )
                }
            )
        }
    }
}


class UnitsManagerVM : ObservableObject {
    
    private var original: UnitsManager
    @Published var model: UnitsManager.Data
    @Published var isAllEditable: Bool = false
    
    private var unitsVM: [UnitVM]
    
    public var UnitsVM: [UnitVM] { unitsVM }
    
    init(unitsManager: UnitsManager) {
        original = unitsManager
        model = original.data
        unitsVM = original.units.map { UnitVM(unit: $0) }
    }
    
    convenience init() {
        self.init(unitsManager: UnitsManager(units: []))
    }
    
    func load() async throws {
        do {
            try await original.load()
            DispatchQueue.main.async {
                self.model = self.original.data
                self.unitsVM = self.original.units.map { UnitVM(unit: $0) }
            }
        } catch {
            // DEV: this should be replaced with proper error handling before ever going to prod
            print("ERROR: Failed to load VM...")
        }
    }
    
    func updateUnit(_ unitVM: UnitVM) async throws {
        guard let index = unitsVM.firstIndex(where: { $0.id == unitVM.id }) else { return }
        let updatedUnit = unitsVM[index].model
        original.units[index].update(from: updatedUnit)
        do {
            try await original.save()
            DispatchQueue.main.async {
                self.model = self.original.data
            }
        } catch {
            // DEV: this should be replaced with proper error handling before ever going to prod
            print("ERROR: Failed to save VM...")
        }
    }
    
    var TotalAverage: Double? {
        return original.getTotalAverage()
    }

    var ProfessionalAverage: Double? {
        return original.getProfessionalAverage()
    }
}
