//
//  GenTaleView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleView: View {
    
    @State var viewModel = GenTaleViewModel()
    
    var body: some View {
        VStack {
            GenTaleTextField(text: $viewModel.theme, placeHolder: "Un reino con caballeros, princesas y dragones...", title: "Temática")
            GenTaleTextField(text: $viewModel.place, placeHolder: "Un bosque...", title: "Lugar")
        }
    }
}

#Preview {
    GenTaleView()
}
