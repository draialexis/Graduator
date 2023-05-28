//
//  UnitViewCell.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct UnitViewCell: View {
    @ObservedObject var unitVM: UnitVM
    @ObservedObject var unitsManagerVM: UnitsManagerVM

    var body: some View {
        VStack {
            
            HStack {
                Text("UE " + String(unitVM.model.code))
                    .frame(width: 40)
                TextField("", text: $unitVM.model.name)
                    .disabled(!unitsManagerVM.isAllEditable)
                Spacer()
                TextField("", value: $unitVM.model.weight, formatter: Formatters.weightFormatter)
                    .frame(width: 30)
                    .disabled(!unitsManagerVM.isAllEditable)
            }
            
            HStack {
                if let average = unitVM.Average {
                    
                    ProgressView(value: average, total: 1.0)
                        .accentColor(average < 0.5 ? .red : .green)
                        .scaleEffect(x: 1, y: 4, anchor: .center)
                    
                    Text(String(format: "%.2f", average * 20.0))
                    
                    Spacer()

                    Image(systemName: "snowflake.circle.fill")
                        .foregroundColor(unitVM.IsCalled ? .primary : .gray)
                    
                } else {
                    NoGradesInfo()
                }
            }

        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct UnitViewCell_Previews: PreviewProvider {
    static var ManagerVMStub: UnitsManagerVM = UnitsManagerVM(
        unitsManager: UnitsManager(
            units: Stub.units
        )
    )
    static var previews: some View {
        UnitViewCell(
            unitVM: UnitVM(unit: Stub.units[0]),
            unitsManagerVM: ManagerVMStub
        )
    }
}
