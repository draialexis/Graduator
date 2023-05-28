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
    }
    
    var data: Data {
        Data(
            id: self.id,
            name: self.name,
            weight: self.weight,
            grade: self.grade
        )
    }
    
    mutating func update(from data: Data) {
        guard data.id == self.data.id else { return }
        if (!data.name.isEmpty) {
            self.name = data.name
        }
        self.weight = max(abs(data.weight), 1)
        if let grade = data.grade {
            self.grade = max(abs(grade), 0.0)
        } else {
            self.grade = nil
        }
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
            weight: 1
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
