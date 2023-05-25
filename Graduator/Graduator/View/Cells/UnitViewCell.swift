//
//  UnitViewCell.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct UnitViewCell: View {
    @ObservedObject var unitVM: UnitVM

    var body: some View {
        VStack {
            
            HStack {
                Text("UE " + String(unitVM.model.code))
                Text(unitVM.model.name)
                Spacer()
                Text(String(unitVM.model.weight))
            }
            
            if let average = unitVM.Average {
                HStack {
                    // TODO add slider linked to "grade" value
                    // TODO link slider color to the average. If below 10.0, red, else green.
                    Text("Sliiiiiiiiiiiiider")
                        .background(Color.red)
                    Text(String(format: "%.2f", average * 20))
                    Spacer()
                }
            } else {
                NoGradesInfo()
            }

        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct UnitViewCell_Previews: PreviewProvider {
    static var previews: some View {
        UnitViewCell(unitVM: UnitVM(unit: Stub.units[0]))
    }
}
