//
//  GenTaleView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleView: View {
    
    @Binding var taleToSave: String
    @State private var tale = TaleModel()
    
    @State private var selectedStage: TaleModel.Stage = .child
    @State private var selectedLength: TaleModel.Length = .paragraphs
    @State private var numberOf = "5"
    
    @State private var showGPTResponse = false
    @State private var chatGPTResponse = ""
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var showLoader = false
    
    let chatGPT = ChatGPTAPIClient()
    
    private func generatePrompt() -> String {
        return ""
    }
    
    var body: some View {
        LoaderView(isShowing: $showLoader) {
            ScrollView {
                VStack {
                    VStack {
                        Text("GRIMM")
                            .font(.largeTitle)
                        Text("Generador de Cuentos con IA")
                            .font(.headline)
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    GenTaleTextField(showLoader: $showLoader, text: $tale.theme, placeHolder: "Un reino con caballeros, princesas y dragones...", title: "Temática", genSuggestion: .theme)
                    GenTaleCharacterView(characters: $tale.characters)
                    GenTaleTextField(showLoader: $showLoader, text: $tale.place, placeHolder: "Un bosque...", title: "Lugar", genSuggestion: .place)
                    GenTaleTextField(showLoader: $showLoader, text: $tale.moral, placeHolder: "Valorar la amistad...", title: "Moraleja", genSuggestion: .moral)
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
                    GenTaleTextField(showLoader: $showLoader, text: $tale.author, placeHolder: "Los Hermanos Grimm...", title: "Autor", genSuggestion: .author)
                    Button {
                        Task {
                            do {
                                showLoader.toggle()
                                let prompt = generatePrompt()
                                chatGPTResponse = try await chatGPT.generateTextWithPrompt(prompt)
                            } catch {
                                showLoader.toggle()
                                showError.toggle()
                                errorMessage = error.localizedDescription
                            }
                        }
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
            .onChange(of: chatGPTResponse) { chatGPTResponse in
                showLoader.toggle()
                showGPTResponse.toggle()
            }
            .onTapGesture {
                hideKeyboard()
            }
            .alert(isPresented: $showError) {
                return Alert(title: Text("HTTP ERROR"), message: Text(errorMessage))
            }
            .sheet(isPresented: $showGPTResponse) {
                ScrollView {
                    Text(chatGPTResponse.isEmpty ? "Ocurrió un problema al generar cuento" : chatGPTResponse)
                        .padding()
                }
                .textSelection(.enabled)
            }
        }
    }
}

#Preview {
    GenTaleView(taleToSave: .constant(""))
}
