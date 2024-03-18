//
//  TaleModel.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import Foundation

struct TaleModel {
    var theme: String = ""
    var characters: [Character] = []
    var place: String = ""
    var moral: String = ""
    var length: (type: Length, numberOf: Int) = (type: .paragraphs, numberOf: 5)
    var stage: Stage = .child
    var author: String = ""
    
    struct Character: Identifiable {
        var id = UUID()
        var name: String = ""
        var age: Int = 0
        var sex: Sex = .male
        var specie: String = ""
        var profession: String = ""
        var personality: String = ""
        var role: Role = .neutral
        
        enum Sex: String, CaseIterable {
            case male = "hombre"
            case female = "mujer"
        }

        enum Role: String, CaseIterable {
            case hero = "héroe"
            case villain = "villano"
            case neutral = "neutro"
        }
    }
    
    enum Length: String, CaseIterable {
        case words
        case paragraphs
    }

    enum Stage: String, CaseIterable {
        case baby = "bebé"
        case preschooler = "preescolar"
        case child = "infante"
        case preteenager = "preadolescente"
        case teenager = "adolescente"
    }
}
