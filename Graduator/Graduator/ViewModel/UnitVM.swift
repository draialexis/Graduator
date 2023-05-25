//
//  UnitVM.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

extension Unit {
    struct Data: Identifiable {
        let id: UUID
        var name: String
        var weight: Int
        var isProfessional: Bool
        var code: Int
        public var subjects: [Subject.Data] = []
    }
    
    var data: Data {
        Data(
            id: self.id,
            name: self.name,
            weight: self.weight,
            isProfessional: self.isProfessional,
            code: self.code,
            subjects: self.subjects.map{ $0.data }
        )
    }
    
    
    // TODO ? Maybe check that we're not setting isCalled to true on a subject with a nil grade. Keep in mind that's what we already did in SubjectVM's update function
    mutating func update(from data: Data) {
        guard self.id == data.id else {return}
        self.name = data.name
        self.weight = data.weight
        self.isProfessional = data.isProfessional
        self.code = data.code
        self.subjects = data.subjects.map {
            Subject(
                id: $0.id,
                name: $0.name,
                weight: $0.weight,
                grade: $0.grade,
                isCalled: $0.isCalled
            )
        }
    }
}

class UnitVM : ObservableObject {
    var original: Unit
    @Published var model: Unit.Data
    @Published var isEdited: Bool = false
    
    
    init(unit: Unit) {
        original = unit
        model = original.data
    }
    
    convenience init() {
        self.init(unit: Unit(
            id: UUID(),
            name: "",
            weight: 1,
            isProfessional: false,
            code: -1,
            subjects: []
        ))
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
    
    // TODO Maybe move this to the model?
    var Average: Double? {
        var totalWeight = 0
        var weightedSum = 0.0

        for subject in model.subjects {
            if let grade = subject.grade {
                totalWeight += subject.weight
                weightedSum += grade * Double(subject.weight)
            }
        }

        guard totalWeight > 0 else { return nil }

        return weightedSum / Double(totalWeight)
    }

    var isCalled: Bool {
        // FIXME this is false if any suject therein has a nil grade. This is true if all subjects therein are locked
        // also check if this can stay a function, or if it would be better as a calculated property
        return false
    }
}
