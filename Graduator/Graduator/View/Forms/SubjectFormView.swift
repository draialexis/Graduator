//
//  SubjectForm.swift
//  Graduator
//
//  Created by etudiant on 2023-05-28.
//

import SwiftUI

struct SubjectFormView: View {
    @ObservedObject var formVM: SubjectFormVM
    
    var body: some View {
        Form {
            HStack {
                Text("Nom de la matière:")
                Spacer()
                TextField("Nom", text: $formVM.name)
            }
            HStack {
                Text("Coefficient:")
                Spacer()
                TextField("Coefficient", value: $formVM.weight, formatter: NumberFormatter())
            }
            HStack {
                Text("Note sur 20.0:")
                Spacer()
                TextField("Note", text: $formVM.gradeString)
            }
            Toggle("Note définitive?", isOn: $formVM.isCalled)
        }
    }
}


struct SubjectFormView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectFormView(formVM: SubjectFormVM())
    }
}
