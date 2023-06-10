//
//  Subject.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct Subject : Identifiable, Codable, WeightedGrade {
    let id: UUID
    var name: String
    var weight: Int
    var grade: Double?
    
    func gradeIsValid(_ grade: Double?) -> Bool {
        return grade == nil || (grade! >= 0 && grade! <= 1)
    }
}
