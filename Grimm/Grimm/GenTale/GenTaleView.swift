//
//  GenTaleView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleView: View {
    
    @State var tale = TaleModel()
    @State private var selectedStage: TaleModel.Stage = .child
    @State private var selectedLength: TaleModel.Length = .paragraphs
    @State private var numberOf = "5"
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("GRIMM")
                        .font(.largeTitle)
                    Text("Generador de Cuentos con IA")
                        .font(.headline)
                }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                GenTaleTextField(text: $tale.theme, placeHolder: "Un reino con caballeros, princesas y dragones...", title: "Temática", genSuggestion: .theme)
                GenTaleCharacterView(characters: $tale.characters)
                GenTaleTextField(text: $tale.place, placeHolder: "Un bosque...", title: "Lugar", genSuggestion: .place)
                GenTaleTextField(text: $tale.moral, placeHolder: "Valorar la amistad...", title: "Moraleja", genSuggestion: .moral)
                HStack {
                    Text("Formato")
                        .font(.headline)
                    Picker("Longitud", selection: $tale.length.type) {
                        ForEach(TaleModel.Length.allCases, id: \.self) { length in
                            Text(length.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("#")
                        .font(.headline)
                    TextField(" ", text: $numberOf)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                        .onChange(of: numberOf) { numberOf in
                            if let number = Int(numberOf) {
                                tale.length.numberOf = number
                            }
                        }
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                HStack {
                    Text("Etapa")
                        .font(.headline)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                    Picker("Etapa", selection: $tale.stage) {
                        ForEach(TaleModel.Stage.allCases, id: \.self) { stage in
                            Text(stage.rawValue.capitalized)
                        }
                    }
                }
                GenTaleTextField(text: $tale.author, placeHolder: "Los Hermanos Grimm...", title: "Autor", genSuggestion: .author)
                Button {
                    dump(tale)
                } label: {
                    VStack {
                        Image(systemName: "hands.and.sparkles.fill")
                        Text("Generar Cuento")
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    GenTaleView()
}
