//
//  SubjectViewCell.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct SubjectViewCell: View {
    @ObservedObject var subjectVM: SubjectVM

    //TODO also allow using the unitview's navigation bar item "Edit" (makes all subjects editable, and more)
    @State private var isEditable = false
    
    private let gradeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    var body: some View {
        HStack {
            if isEditable {
                VStack {
                    Image(systemName: "checkmark.square")
                    Button(action: {
                        isEditable = false
                        subjectVM.onEdited(isCancelled: true)
                    }) {
                        Image(systemName: "nosign.app")
                            .padding(.top, 10.0)
                            .foregroundColor(.pink)
                    }
                }
            } else {
                Button(action: {
                    isEditable = true
                    subjectVM.onEditing()
                }) {
                    Image(systemName: "lock")
                }
            }

            VStack {
                HStack {
                    TextField("", text: $subjectVM.model.name)
                        .disabled(!isEditable)


                    TextField("", value: $subjectVM.model.weight, formatter: NumberFormatter())
                        .frame(width: 20)
                        .disabled(!isEditable)
                }

                HStack {
                    if let grade = subjectVM.model.grade {
                        Slider(value: Binding(
                            get: { grade },
                            set: { newValue in
                                if isEditable {
                                    subjectVM.model.grade = newValue
                                }
                            }
                        ), in: 0...1, step: 0.001)
                        .accentColor(grade < 0.5 ? .red : .green)
                        .disabled(!isEditable || subjectVM.model.isCalled)

                        TextField("", value: Binding(
                            get: { grade * 20.0 },
                            set: { newValue in
                                if isEditable {
                                    subjectVM.model.grade = newValue / 20.0
                                }
                            }
                        ), formatter: gradeFormatter)
                        .frame(width: 50)
                        .disabled(!isEditable)
     
                        Image(systemName: "snowflake.circle.fill")
                            .foregroundColor(subjectVM.model.isCalled ? .primary : .gray)

                        Toggle("", isOn: $subjectVM.model.isCalled)
                            .frame(width: 50)
                            .disabled(!isEditable)
                        
                    } else {
                        NoGradesInfo()
                        Button(action: {
                            subjectVM.model.grade = 0.0
                        }) {
                            Image(systemName: "pencil.line")
                        }
                        .disabled(!isEditable)

                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


struct SubjectViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SubjectViewCell(subjectVM: SubjectVM(subject: Stub.units[0].subjects[0]))
    }
}
