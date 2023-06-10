//
//  WeightedGrade.swift
//  Graduator
//
//  Created by etudiant on 2023-06-10.
//

import Foundation

protocol WeightedGrade {
    var weight: Int { get }
    var grade: Double? { get }
}
