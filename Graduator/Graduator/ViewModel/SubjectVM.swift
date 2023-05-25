//
//  SubjectVM.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

extension Subject {
    struct Data: Identifiable {
        let id: UUID
        var name: String
        var weight: Int
        var grade: Double?
        var isCalled: Bool
    }
    
    init(subjectData: Subject.Data) {
        self.id = subjectData.id
        self.name = subjectData.name
        self.weight = subjectData.weight
        self.grade = subjectData.grade
        self.isCalled = subjectData.isCalled
    }
    
    var data: Data {
        Data(
            id: self.id,
            name: self.name,
            weight: self.weight,
            grade: self.grade,
            isCalled: self.isCalled
        )
    }
    
    mutating func update(from data: Data) {
        // FIXME improve the guard
        guard (data.id == self.data.id
               && (self.isCalled == false || data.isCalled == false)
               && (data.grade != nil || data.isCalled == false))
        else { return }
        
        self.name = data.name
        self.weight = data.weight
        self.grade = data.grade
        self.isCalled = data.isCalled
    }
}

class SubjectVM : ObservableObject {
    var original: Subject
    @Published var model: Subject.Data
    @Published var isEdited: Bool = false
    
    init(subject: Subject) {
        original = subject
        model = original.data
    }
    
    init(subjectData: Subject.Data) {
        self.original = Subject(subjectData: subjectData)
        self.model = subjectData
    }
    
    convenience init() {
        self.init(subject: Subject(
            id: UUID(),
            name: "",
            weight: 1,
            grade: 10.0,
            isCalled: false
        ))
    }
    
    func onEditing() {
        model = original.data
        isEdited = true
    }
    
    // TODO add suitable error handling for cases where the user enters an invalid number. (negative numbers are forbidden... Do we need to guard against NaN and nil as well?)
    func onEdited(isCancelled: Bool = false) {
        if(!isCancelled && isEdited){
            original.update(from: model)
        }
        isEdited = false
    }
    
    var HasGrade: Bool {
        return model.grade != nil
    }
}
