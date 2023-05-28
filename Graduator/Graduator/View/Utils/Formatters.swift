//
//  Formatters.swift
//  Graduator
//
//  Created by etudiant on 2023-05-26.
//

import Foundation

class Formatters {
    static let gradeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimum = 0
        formatter.maximum = 20
        return formatter
    }()
    
    static let weightFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimum = 1
        return formatter
    }()
}
