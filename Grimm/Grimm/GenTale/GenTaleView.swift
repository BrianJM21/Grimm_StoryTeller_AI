//
//  GenTaleView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleView: View {
    
    @State var tale = TaleModel()
    
    var body: some View {
        VStack {
            GenTaleTextField(text: $tale.theme, placeHolder: "Un reino con caballeros, princesas y dragones...", title: "Temática", genSuggestion: .theme)
            GenTaleCharacterView(characters: $tale.characters)
            GenTaleTextField(text: $tale.place, placeHolder: "Un bosque...", title: "Lugar", genSuggestion: .place)
        }
    }
}

#Preview {
    GenTaleView()
}
