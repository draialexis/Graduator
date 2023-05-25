//
//  AverageBlockView.swift
//  Graduator
//
//  Created by etudiant on 2023-05-25.
//

import SwiftUI

struct AverageBlockView: View {
    let average: Double
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(String(format: "%.2f", average * 20))
            Image(systemName: average >= 0.5 ? "graduationcap.fill" : "exclamationmark.bubble.fill")
        }
    }
}


struct AverageBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AverageBlockView(average: 0.587, title: "Bleep bloop")
    }
}
