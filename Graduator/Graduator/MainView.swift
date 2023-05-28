//
//  MainView.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var unitsManagerVM: UnitsManagerVM
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading) {
                    Divider()

                    Text("Blocs")
                        .font(.title)
                        .padding(.bottom)
                    
                    Text("Vous devez avoir la moyenne à chacun de ces blocs pour avoir votre diplôme.")
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    if let totalAverage = unitsManagerVM.TotalAverage {
                        AverageBlockView(average: totalAverage, title: "Moyenne totale")
                    } else {
                        NoGradesInfo()
                    }

                    if let professionalAverage = unitsManagerVM.ProfessionalAverage {
                        AverageBlockView(average: professionalAverage, title: "Moyenne professionnelle")
                    } else {
                        NoGradesInfo()
                    }

                    Divider()

                    Text("UEs")
                        .font(.title)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    ForEach(unitsManagerVM.UnitsVM) { unitVM in
                        NavigationLink(destination: UnitView(
                            unitVM: unitVM,
                            unitsManagerVM: unitsManagerVM
                        )) {
                            UnitViewCell(
                                unitVM: unitVM,
                                unitsManagerVM: unitsManagerVM
                            )
                        }
                    }
                }
            }
            .navigationTitle("Graduator")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var ManagerVMStub: UnitsManagerVM = UnitsManagerVM(
        unitsManager: UnitsManager(
            units: Stub.units
        )
    )

    static var previews: some View {
        MainView(unitsManagerVM: ManagerVMStub)
    }
}
