//
//  SubjectViewCell.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct SubjectViewCell: View {
    @ObservedObject var subjectVM: SubjectVM
    @ObservedObject var unitVM: UnitVM
    @ObservedObject var unitsManagerVM: UnitsManagerVM
        
    @State private var isGradeEditable = false

    var body: some View {
        HStack {
            VStack {
                HStack {
                    TextField("", text: $subjectVM.model.name)
                        .disabled(!unitsManagerVM.isAllEditable)

                    TextField("", value: $subjectVM.model.weight, formatter: Formatters.weightFormatter)
                        .frame(width: 40)
                        .disabled(!unitsManagerVM.isAllEditable)
                }

                HStack {
                    if let grade = subjectVM.model.grade {
                        VStack {
                            Toggle("", isOn: $isGradeEditable)
                                .frame(width: 40)
                                .onChange(of: isGradeEditable) { value in
                                    if !value {
                                        Task {
                                            do {
                                                subjectVM.onEdited()
                                                unitVM.updateSubject(subjectVM)
                                                try await unitsManagerVM.updateUnit(unitVM)
                                            } catch {
                                                // DEV: this should be replaced with proper error handling before ever going to prod
                                                print("ERROR: Failed to update grade: \(error)")
                                            }
                                        }
                                    }
                                }
                            Image(systemName: isGradeEditable ? "checkmark" : "lock.open")
                        }
                        Slider(value: Binding(
                            get: { grade },
                            set: { newValue in
                                if isGradeEditable {
                                    subjectVM.model.grade = newValue
                                }
                            }
                        ), in: 0...1, step: 0.001)
                        .accentColor(grade < 0.5 ? .red : .green)
                        .disabled(!isGradeEditable)

                        TextField("", value: Binding(
                            get: { grade * 20.0 },
                            set: { newValue in
                                if isGradeEditable {
                                    subjectVM.model.grade = newValue / 20.0
                                }
                            }
                        ), formatter: Formatters.gradeFormatter)
                        .frame(width: 50)
                        .disabled(!isGradeEditable)
                    } else {
                        NoGradesInfo()
                        Button(action: {
                            subjectVM.model.grade = 0.0
                            isGradeEditable = true
                        }) {
                            Image(systemName: "pencil.line")
                        }
                    }
                }
                .padding(.bottom)
            }
        }
    }
}


struct SubjectViewCell_Previews: PreviewProvider {
    static var ManagerVMStub: UnitsManagerVM = UnitsManagerVM(
        unitsManager: UnitsManager(
            units: Stub.units
        )
    )
    
    static var previews: some View {
        SubjectViewCell(
            subjectVM: ManagerVMStub.UnitsVM[0].SubjectsVM[0],
            unitVM: ManagerVMStub.UnitsVM[0],
            unitsManagerVM: ManagerVMStub
        )
    }
}
