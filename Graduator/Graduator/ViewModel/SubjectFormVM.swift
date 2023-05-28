//
//  SubjectFormVM.swift
//  Graduator
//
//  Created by etudiant on 2023-05-28.
//

import Foundation

class SubjectFormVM: ObservableObject {
    @Published var name: String = ""
    @Published var weight: Int = 1
    @Published var gradeString: String = ""
    
    var grade: Double? {
        if let gradeOverTwenty = Double(gradeString) {
            return gradeOverTwenty / 20.0
        } else {
            return nil
        }
    }
    
    func isValid(_ subject: Subject) -> Bool {
        return !(name.isEmpty || weight <= 0 || !subject.gradeIsValid(grade))
    }
    
    func createSubject() -> Subject? {
        let subject = Subject(
            id: UUID(),
            name: name,
            weight: weight,
            grade: grade)
        guard isValid(subject) else { return nil }
        return subject
    }
}
