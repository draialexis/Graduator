//
//  GraduatorApp.swift
//  Graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

@main
struct GraduatorApp: App {
    @StateObject var unitsManagerVM = UnitsManagerVM()

    var body: some Scene {
        WindowGroup {
            MainView(unitsManagerVM: unitsManagerVM)
                .environmentObject(unitsManagerVM)
        }
    }
}
