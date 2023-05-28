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
        var subjects: [Subject.Data] = []
    }
    
    var data: Data {
        Data(
            id: self.id,
            name: self.name,
            weight: self.weight,
            isProfessional: self.isProfessional,
            code: self.code,
            subjects: self.subjects.map { $0.data }
        )
    }
    
    mutating func update(from data: Data) {
        guard self.id == data.id else {return}
        if (!data.name.isEmpty) {
            self.name = data.name
        }
        self.weight = max(abs(data.weight), 1)
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

class UnitVM : ObservableObject, Identifiable {
    private var original: Unit
    var id: UUID { original.id }
    @Published var model: Unit.Data
    @Published var isEdited: Bool = false
    
    private var subjectsVM: [SubjectVM]
    
    public var SubjectsVM: [SubjectVM] { subjectsVM }
    
    init(unit: Unit) {
        original = unit
        model = original.data
        subjectsVM = unit.subjects.map { SubjectVM(subject: $0) }
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
        if(!isCancelled){
            original.update(from: model)
        }
        model = original.data
        isEdited = false
    }
    
    func updateSubject(_ subjectVM: SubjectVM) {
        guard let index = subjectsVM.firstIndex(where: { $0.id == subjectVM.id }) else { return }
        let updatedSubject = subjectsVM[index].model
        original.subjects[index].update(from: updatedSubject)
        model = original.data
    }
    
    func updateAllSubjects() {
        for subjectVM in subjectsVM {
            updateSubject(subjectVM)
        }
    }
    
    func deleteSubject(_ subjectVM: SubjectVM) {
        guard let index = subjectsVM.firstIndex(where: { $0.id == subjectVM.id }) else { return }
        subjectsVM.remove(at: index)
        original.subjects.remove(at: index)
        model = original.data
    }
    
    func addSubject(_ subject: Subject) {
        subjectsVM.append(SubjectVM(subject: subject))
        original.subjects.append(subject)
        model = original.data
    }
    
    var Average: Double? {
        return original.getAverage()
    }

    var IsCalled: Bool {
        return original.subjects.allSatisfy { $0.isCalled }
    }
}
