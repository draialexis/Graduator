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
}
