//
//  Unit.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct Unit : Identifiable, Codable, WeightedGrade {
    let id: UUID
    var name: String
    var weight: Int
    var grade: Double? { getAverage() }
    var isProfessional: Bool
    var code: Int
    var subjects: [Subject]
    
    func getAverage() -> Double? {
        return WeightedAverageCalculator.average(elements: subjects)
    }
}
