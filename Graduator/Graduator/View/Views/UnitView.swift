//
//  UnitView.swift
//  graduator
//
//  Created by etudiant on 2023-05-23.
//

import SwiftUI

struct UnitView: View {
    @ObservedObject var unitVM: UnitVM
    @ObservedObject var unitsManagerVM: UnitsManagerVM

    @State private var showAlert = false
    @State private var showingForm: Bool = false
    var formVM = SubjectFormVM()
    
    private func delete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let subjectVMToDelete = unitVM.SubjectsVM[index]
        unitVM.deleteSubject(subjectVMToDelete)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("UE " + String(unitVM.model.code))
                Text(unitVM.model.name)
            }
            .font(.title)
            .padding()
            
            UnitViewCell(
                unitVM: unitVM,
                unitsManagerVM: unitsManagerVM
            )
            
            Divider()
            
            HStack {
                Image(systemName: "multiply.circle.fill")
                Text(String(format: "coefficient : %d", unitVM.model.weight))
            }
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "magnifyingglass.circle")
                Text("Détail des notes")
            }
            .padding(.horizontal)

            
            List {
                if unitsManagerVM.isAllEditable {
                    ForEach(unitVM.SubjectsVM) { subjectVM in
                        SubjectViewCell(
                            subjectVM: subjectVM,
                            unitVM: unitVM,
                            unitsManagerVM: unitsManagerVM
                        )
                    }
                    .onDelete(perform: delete)
                } else {
                    ForEach(unitVM.SubjectsVM) { subjectVM in
                        SubjectViewCell(
                            subjectVM: subjectVM,
                            unitVM: unitVM,
                            unitsManagerVM: unitsManagerVM
                        )
                    }
                }
            }
            .navigationBarItems(trailing: HStack {
                if unitsManagerVM.isAllEditable {
                    Button(action: { showingForm = true }) {
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        unitVM.isEdited = false
                        unitsManagerVM.isAllEditable.toggle()
                        unitVM.onEdited(isCancelled: true)
                        unitVM.SubjectsVM.forEach { $0.onEdited(isCancelled: true) }
                    }) {
                        Text("Annuler")
                    }
                    Button(action: {
                        Task {
                            do {
                                unitsManagerVM.isAllEditable.toggle()
                                unitVM.onEdited()
                                unitVM.updateAllSubjects()
                                try await unitsManagerVM.updateUnit(unitVM)
                            } catch {
                                // DEV: this should be replaced with proper error handling before ever going to prod
                                print("ERROR: Failed to update unit: \(error)")
                            }
                        }
                    }) {
                        Text("OK")
                    }
                } else {
                    Button(action: {
                        unitsManagerVM.isAllEditable.toggle()
                        unitVM.onEditing()
                    }) {
                        Text("Modifier")
                    }
                }
            })
            .sheet(isPresented: $showingForm) {
                NavigationView {
                    SubjectFormView(formVM: formVM)
                        .navigationTitle("Nouvelle matière")
                        .navigationBarItems(
                            leading: Button("Annuler") { showingForm = false },
                            trailing: Button("Enregistrer") {
                                if let newSubject = formVM.createSubject() {
                                    Task {
                                        do {
                                            unitVM.addSubject(newSubject)
                                            try await unitsManagerVM.updateUnit(unitVM)
                                            showingForm = false
                                        } catch {
                                            // DEV: this should be replaced with proper error handling before ever going to prod
                                            print("ERROR: Failed to create unit: \(error)")
                                        }
                                    }
                                } else {
                                    showAlert = true
                                }
                            }.alert(isPresented: $showAlert) {
                                Alert(title: Text("Annulé: matière invalide"),
                                      message: Text("C'est un peu plus compliqué que ça..."),
                                      dismissButton: .default(Text("OK")))
                            })
                }
            }
        }
        // If user navigates back while editing but before clicking 'OK', the changes are cancelled
        .onDisappear(perform: {
            if unitsManagerVM.isAllEditable {
                unitVM.isEdited = false
                unitVM.onEdited(isCancelled: true)
                unitsManagerVM.isAllEditable = false
            }
        })
    }
}

struct UnitView_Previews: PreviewProvider {
    
    static var ManagerVMStub: UnitsManagerVM = UnitsManagerVM(
        unitsManager: UnitsManager(
            units: Stub.units
        )
    )
    
    static var previews: some View {
        UnitView(
            unitVM: ManagerVMStub.UnitsVM[0],
            unitsManagerVM: ManagerVMStub
        )
    }
}
