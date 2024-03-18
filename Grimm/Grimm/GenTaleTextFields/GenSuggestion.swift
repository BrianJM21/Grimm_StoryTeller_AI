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
    
    static func generateSuggestion(for suggestion: Self) {
        switch suggestion {
            
        case .theme:
            print("generate suggestion for Theme")
            
        case .nameCharacter:
            print("generate suggestion for Name Character")
            
        case .ageCharacter:
            print("generate suggestion for Age Character")
            
        case .specieCharacter:
            print("generate suggestion for Specie Character")
            
        case .professionCharacter:
            print("generate suggestion for Profession Character")
            
        case .personalityCharacter:
            print("generate suggestion for Personality Character")
            
        case .place:
            print("generate suggestion for Place")
            
        case .moral:
            print("generate suggestion for Moral")
            
        case .author:
            print("generate suggestion for Author")
            
        case .none:
            break
        }
    }
}
