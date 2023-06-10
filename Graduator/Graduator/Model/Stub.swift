//
//  Stub.swift
//  Graduator
//
//  Created by etudiant on 2023-05-25.
//

import Foundation

struct Stub {
    static let units : [Unit] = [
        Unit(
            id: UUID(),
            name: "Génie logiciel",
            weight: 6,
            isProfessional: false,
            code: 1,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Processus de développement",
                    weight: 4,
                    grade: 13.17/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Programmation Orientée Objet",
                    weight: 9,
                    grade: 13.63/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Qualité de développement",
                    weight: 5,
                    grade: 12.4/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Remise à niveau objets",
                    weight: 4,
                    grade: 20.0/20.0
                ),
            ]
        ),
        Unit(
            id: UUID(),
            name: "Systèmes et réseaux",
            weight: 6,
            isProfessional: false,
            code: 2,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Internet des Objets",
                    weight: 4
                ),
                Subject(
                    id: UUID(),
                    name: "Réseaux",
                    weight: 4,
                    grade: 14.5/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Services mobiles",
                    weight: 4
                ),
                Subject(
                    id: UUID(),
                    name: "Système",
                    weight: 5,
                    grade: 13.88/20.0
                ),
            ]
        ),
        Unit(
            id: UUID(),
            name: "Insertion professionnelle",
            weight: 6,
            isProfessional: false,
            code: 3,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Anglais",
                    weight: 5,
                    grade: 18.65/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Communication",
                    weight: 4,
                    grade: 17.13/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Économie",
                    weight: 4,
                    grade: 9.5/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Gestion",
                    weight: 3,
                    grade: 9.5/20.0
                ),
            ]
        ),
        Unit(
            id: UUID(),
            name: "Technologies mobiles 1",
            weight: 9,
            isProfessional: false,
            code: 4,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Android",
                    weight: 6,
                    grade: 4.0/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Architecture de projet C# .NET (1)",
                    weight: 5,
                    grade: 14.5/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "C++",
                    weight: 4,
                    grade: 10.2/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Swift",
                    weight: 5,
                    grade: 14.93/20.0
                ),
            ]
        ),
        Unit(
            id: UUID(),
            name: "Technologies mobiles 2",
            weight: 9,
            isProfessional: false,
            code: 5,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Architecture de projet C# .NET (2)",
                    weight: 4,
                    grade: 12.17/20.0
                ),
                Subject(
                    id: UUID(),
                    name: "Client/Serveur",
                    weight: 4
                ),
                Subject(
                    id: UUID(),
                    name: "iOS",
                    weight: 5
                ),
                Subject(
                    id: UUID(),
                    name: "Multiplateformes",
                    weight: 3
                ),
                Subject(
                    id: UUID(),
                    name: "Qt Quick",
                    weight: 5
                ),
                Subject(
                    id: UUID(),
                    name: "Xamarin",
                    weight: 5
                ),
            ]
        ),
        Unit(
            id: UUID(),
            name: "Projet",
            weight: 9,
            isProfessional: true,
            code: 6,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Projet",
                    weight: 1,
                    grade: 13.66/20.0
                )
            ]
        ),
        Unit(
            id: UUID(),
            name: "Stage",
            weight: 15,
            isProfessional: true,
            code: 7,
            subjects: [
                Subject(
                    id: UUID(),
                    name: "Stage",
                    weight: 1
                )
            ]
        )
    ]
}
