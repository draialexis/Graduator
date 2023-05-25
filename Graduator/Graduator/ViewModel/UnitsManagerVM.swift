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
            units: self.getUnits().map{ $0.data }
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
                        grade: $0.grade,
                        isCalled: $0.isCalled
                    )
                }
            )
        }
    }
}


class UnitsManagerVM : ObservableObject {
    
    var original: UnitsManager
    @Published var model: UnitsManager.Data
    @Published var isEdited: Bool = false

    private var unitsVM: [UnitVM]
    
    public var UnitsVM: [UnitVM] {
        unitsVM
    }
     
    init(unitsManager: UnitsManager) {
        original = unitsManager
        model = original.data
        unitsVM = unitsManager.getUnits().map {
            UnitVM(unit: $0)
        }
    }

    convenience init() {
        self.init(unitsManager: UnitsManager(units: Stub.units))
    }
    
    func onEditing() {
        model = original.data
        isEdited = true
    }
    
    func onEdited(isCancelled: Bool = false) {
        if(!isCancelled && isEdited){
            original.update(from: model)
        }
        isEdited = false
    }
    
    var TotalAverage: Double? {
        return getAverage(unitsVM: self.unitsVM)
    }

    var ProfessionalAverage: Double? {
        return getAverage(unitsVM: self.unitsVM.filter { $0.model.isProfessional })
    }

    private func getAverage(unitsVM: [UnitVM]) -> Double? {
        var totalWeight = 0
        var weightedSum = 0.0

        for unitVM in unitsVM {
            if let grade = unitVM.Average {
                totalWeight += unitVM.model.weight
                weightedSum += grade * Double(unitVM.model.weight)
            }
        }
        
        guard totalWeight > 0 else { return nil }
        
        return weightedSum / Double(totalWeight)
    }
    
    // FIXME fix this nightmare after resting and doing Subject first
    /*
    func updateUnit(id: UUID, unitVM: UnitVM) -> UnitVM? {
        if let index = unitsVM.firstIndex(where: { $0.model.id == id }) {
            original.updateUnit(id: id, unit: Unit(unitsVM[index].original))
            return unitVM
        } else {
            return nil
        }
    }
     */
}



