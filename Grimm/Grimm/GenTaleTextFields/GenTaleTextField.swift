//
//  GenTaleTextField.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleTextField: View {
    
    @Binding var showLoader: Bool
    @Binding var text: String
    
    let placeHolder: String
    let title: String
    var genSuggestion: GenSuggestion
    
    @State private var localText: String = ""
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var suggestionText = ""
    @State private var showSuggestionText = false
    
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
                    Task {
                        do {
                            showLoader.toggle()
                            suggestionText = try await GenSuggestion.generateSuggestion(for: genSuggestion)
                        } catch {
                            showLoader.toggle()
                            showError.toggle()
                            errorMessage = error.localizedDescription
                        }
                    }
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
        .onChange(of: suggestionText) { suggestionText in
            showLoader.toggle()
            showSuggestionText.toggle()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert(isPresented: $showError) {
            return Alert(title: Text("HTTP ERROR"), message: Text(errorMessage))
        }
        .sheet(isPresented: $showSuggestionText) {
            ScrollView {
                Text(suggestionText.isEmpty ? "Ocurrió un problema al generar sugerencia" : suggestionText)
                    .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
            }
            .textSelection(.enabled)
        }
    }
}

#Preview {
    GenTaleTextField(showLoader: .constant(false), text: .constant(""), placeHolder: "Escribe tu texto aquí", title: "Título", genSuggestion: .none)
}
