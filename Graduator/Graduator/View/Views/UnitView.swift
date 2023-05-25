//
//  UnitView.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct UnitView: View {
    @ObservedObject var unitVM: UnitVM

    var body: some View {
        VStack(alignment: .leading) {
            Text("Unit title")
                .font(.title)
                .padding()
            
            UnitViewCell(unitVM: unitVM)
            
            Divider()
            
            HStack {
                // TODO later add cross image (multiply)
                Text("coefficient : " + "weight")
            }
            .padding(.horizontal)
            
            HStack {
                // TODO later add page with scribbling image
                Text("Détail des notes")
            }
            .padding(.horizontal)

            ScrollView {
                ForEach(unitVM.model.subjects) { subjectData in
                    // You need to convert subjectData into SubjectVM, then use it to create SubjectViewCell
                    let subjectVM = SubjectVM(subjectData: subjectData)
                    SubjectViewCell(subjectVM: subjectVM)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                // TODO later: Add action for button. Make editable
                // * unit weight
                // * unit description
                // * subjects
                //   * make all fields editable (just toggle isEditable is the SubjectCellView?)
                //   * create new subject (creation screen with simple form for name, weight, code, isCalled. Of course, will need to deal with adding it to the unitVM, updating the unitVM, and updating the unitsmanagerVM with the new unitVM. Check the result to make sure that the model does get updated by the VM in the end)
                //   * delete a subject (again, this has repercusions for the unit and the unitmanager, be careful)
            }) {
                Text("Edit")
            })
        }
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(unitVM: UnitVM(unit: Stub.units[5]))
    }
}
