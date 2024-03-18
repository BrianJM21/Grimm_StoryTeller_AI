//
//  GenTaleTextNumberField.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleTextNumberField: View {
    
    @Binding var textNumber: Int
    @State private var localTextNumber: String = ""
    let placeHolder: String
    let title: String
    var genSuggestion: GenSuggestion
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
            HStack {
                TextField(placeHolder, text: $localTextNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .modifier(ClearButtonModifier(text: $localTextNumber))
                    .onChange(of: localTextNumber) { value in
                        if let number = Int(value) {
                            textNumber = number
                        } else {
                            textNumber = 0
                        }
                    }
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
            localTextNumber = textNumber > 0 ? textNumber.description : ""
        }
    }
}

#Preview {
    GenTaleTextNumberField(textNumber: .constant(0), placeHolder: "Escribe tu texto aquí", title: "Título", genSuggestion: .none)
}
