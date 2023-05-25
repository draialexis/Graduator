//
//  Subject.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import Foundation

struct Subject : Identifiable {
    let id: UUID
    var name: String
    var weight: Int
    var grade: Double?
    var isCalled: Bool
}
