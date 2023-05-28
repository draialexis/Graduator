//
//  NoGradesInfo.swift
//  Graduator
//
//  Created by etudiant on 2023-05-25.
//

import SwiftUI

struct NoGradesInfo: View {
    var body: some View {
        HStack {
            Text("Aucune note enregistrée")
            Spacer()
        }
    }
}


struct NoGradesInfo_Previews: PreviewProvider {
    static var previews: some View {
        NoGradesInfo()
    }
}
