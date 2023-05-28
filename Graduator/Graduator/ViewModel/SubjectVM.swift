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
        // papers please
        guard data.id == self.data.id else { return }
        // can't update grade if this subject is called, unless the update is to 'un-call' the subject
        guard !(self.isCalled && data.isCalled && self.grade != data.grade) else { return }
        // can't update a subject to become called and have a nil grade at the same time
        guard !(data.grade == nil && data.isCalled) else { return }

        if (!data.name.isEmpty) {
            self.name = data.name
        }
        self.weight = max(abs(data.weight), 1)
        if let grade = data.grade {
            self.grade = max(abs(grade), 0.0)
        } else {
            self.grade = nil
        }
        self.isCalled = data.isCalled
    }

}

class SubjectVM : ObservableObject, Identifiable {
    private var original: Subject
    var id: UUID { original.id }
    @Published var model: Subject.Data
    @Published var isEdited: Bool = false
    
    init(subject: Subject) {
        original = subject
        model = original.data
    }
    
    convenience init() {
        self.init(subject: Subject(
            id: UUID(),
            name: "",
            weight: 1,
            isCalled: false
        ))
    }
    
    func onEditing() {
        model = original.data
        isEdited = true
    }
    
    func onEdited(isCancelled: Bool = false) {
        if(!isCancelled && original.gradeIsValid(model.grade)){
            original.update(from: model)
        }
        model = original.data
        isEdited = false
    }
}
