//
//  GenTaleTextField.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleTextField: View {
    
    @Binding var text: String
    @State private var localText: String = ""
    let placeHolder: String
    let title: String
    var genSuggestion: GenSuggestion
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
            HStack {
                TextField(placeHolder, text: $localText)
                    .textFieldStyle(.roundedBorder)
                    .modifier(ClearButtonModifier(text: $localText))
                    .onChange(of: localText, perform: { value in
                        text = value
                    })
                Button {
                    GenSuggestion.generateSuggestion(for: genSuggestion)
                } label: {
                    Image(systemName: "sparkles")
                }
                .buttonStyle(.bordered)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .onAppear {
            localText = text
        }
    }
}

#Preview {
    GenTaleTextField(text: .constant(""), placeHolder: "Escribe tu texto aquí", title: "Título", genSuggestion: .none)
}
