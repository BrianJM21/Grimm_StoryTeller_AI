//
//  GenSuggestion.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

enum GenSuggestion {
    case theme
    case nameCharacter
    case ageCharacter
    case specieCharacter
    case professionCharacter
    case personalityCharacter
    case place
    case moral
    case author
    case none
    
    static func generateSuggestion(for suggestion: Self) async throws -> String {
        
        let chatGPT = ChatGPTAPIClient()
        let rootPrompt = "Dame tres sugerencias sobre "
        let tailPrompt = " al escribir un cuento para niños"
        
        switch suggestion {
            
        case .theme:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) temática \(tailPrompt)")
            
        case .nameCharacter:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) nombre de personajes \(tailPrompt)")
            
        case .ageCharacter:
            return String(Int.random(in: 1...200))
            
        case .specieCharacter:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) especies de personaje \(tailPrompt)")
            
        case .professionCharacter:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) profesiones de personaje \(tailPrompt)")
            
        case .personalityCharacter:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) personalidades de personaje \(tailPrompt)")
            
        case .place:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) lugares \(tailPrompt)")
            
        case .moral:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) moralejas \(tailPrompt)")
            
        case .author:
            return try await chatGPT.generateTextWithPrompt("\(rootPrompt) autores que han escrito cuentos infantiles")
            
        case .none:
            break
        }
        return ""
    }
}
