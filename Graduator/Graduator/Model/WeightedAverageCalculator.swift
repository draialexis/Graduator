//
//  WeightedAverageCalculator.swift
//  Graduator
//
//  Created by etudiant on 2023-06-10.
//

import Foundation

struct WeightedAverageCalculator {
    static func average<T: WeightedGrade>(elements: [T]) -> Double? {
        var totalWeight = 0
        var weightedSum = 0.0

        for element in elements {
            if let grade = element.grade {
                totalWeight += element.weight
                weightedSum += grade * Double(element.weight)
            }
        }

        guard totalWeight > 0 else { return nil }

        return weightedSum / Double(totalWeight)
    }
}
