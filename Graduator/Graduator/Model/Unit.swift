//
//  Unit.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct Unit : Identifiable {
    let id: UUID
    var name: String
    var weight: Int
    var isProfessional: Bool
    var code: Int
    var subjects: [Subject]
    
    func getAverage() -> Double? {
        var totalWeight = 0
        var weightedSum = 0.0

        for subject in subjects {
            if let grade = subject.grade {
                totalWeight += subject.weight
                weightedSum += grade * Double(subject.weight)
            }
        }

        guard totalWeight > 0 else { return nil }

        return weightedSum / Double(totalWeight)
    }
}
