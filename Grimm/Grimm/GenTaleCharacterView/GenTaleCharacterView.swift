//
//  GenTaleCharacterView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct GenTaleCharacterView: View {
    
    @State private var showAddCharacter = false
    @State private var newCharacter = TaleModel.Character()
    @State private var selectedRole: TaleModel.Character.Role = .neutral
    @State private var selectedSex: TaleModel.Character.Sex = .male
    
    @Binding var characters: [TaleModel.Character]
    
    @State var characterExists = false
    
    func find(_ character: TaleModel.Character, in characters: inout [TaleModel.Character], to action: FindCharacterAction) -> Int? {
        for (index, characterInArray) in characters.enumerated() {
            if characterInArray.id == character.id {
                switch action {
                case .replace:
                    characters[index] = character
                    return index
                    
                case .delete:
                    characters.remove(at: index)
                    return nil
                    
                case .find:
                    return index
                }
            }
        }
        return nil
    }
    
    var body: some View {
        
        Button("Añadir Personaje") {
            showAddCharacter.toggle()
            newCharacter = TaleModel.Character()
            selectedRole = .neutral
            selectedSex = .male
            characterExists = false
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $showAddCharacter) {
            ScrollView {
                Text("Personaje")
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                GenTaleTextField(text: $newCharacter.name, placeHolder: "Sir Lancelot...", title: "Nombre", genSuggestion: .nameCharacter)
                GenTaleTextNumberField(textNumber: $newCharacter.age, placeHolder: "32...", title: "Edad", genSuggestion: .ageCharacter)
                HStack {
                    Text("Sexo")
                        .font(.headline)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Picker("Sexo", selection: $selectedSex) {
                        ForEach(TaleModel.Character.Sex.allCases, id: \.self) { sex in
                            Text(sex.rawValue.capitalized)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                    .pickerStyle(.segmented)
                    .onChange(of: selectedSex, perform: { sex in
                        newCharacter.sex = sex
                    })
                }
                GenTaleTextField(text: $newCharacter.specie, placeHolder: "Elefante, humano...", title: "Especie", genSuggestion: .specieCharacter)
                GenTaleTextField(text: $newCharacter.profession, placeHolder: "Mago, acróbata...", title: "Profesión", genSuggestion: .professionCharacter)
                GenTaleTextField(text: $newCharacter.personality, placeHolder: "Amigable, enojón...", title: "Personalidad", genSuggestion: .personalityCharacter)
                HStack {
                    Text("Rol")
                        .font(.headline)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                    Picker("Rol", selection: $selectedRole) {
                        ForEach(TaleModel.Character.Role.allCases, id: \.self) { role in
                            Text(role.rawValue.capitalized)
                        }
                    }
                    .onChange(of: selectedRole, perform: { role in
                        newCharacter.role = role
                    })
                }
                if !characterExists {
                    Button("Agregar") {
                        showAddCharacter.toggle()
                        characters.append(newCharacter)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    Button("Modificar") {
                        showAddCharacter.toggle()
                        _ = find(newCharacter, in: &characters, to: .replace)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Button("Eliminar") {
                        showAddCharacter.toggle()
                        _ = find(newCharacter, in: &characters, to: .delete)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .padding()
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        Form {
            ForEach(characters) { character in
                Text(character.name)
                    .onTapGesture {
                        showAddCharacter.toggle()
                        newCharacter = character
                        selectedSex = character.sex
                        selectedRole = character.role
                        characterExists = true
                    }
            }
        }
        .frame(height: !characters.isEmpty ? 150 : 0)
        .scrollContentBackground(.hidden)
    }
}

enum FindCharacterAction {
    case replace
    case delete
    case find
}

#Preview {
    GenTaleCharacterView(characters: .constant([]))
}
