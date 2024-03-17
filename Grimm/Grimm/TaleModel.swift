//
//  TaleModel.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

struct Tale {
    let theme: String
    let characters: [Character]
    let place: String
    let moral: String
    let length: (type: Length, numberOf: Int)
    let stage: Stage
    
    struct Character {
        let name: String
        let age: Int
        let specie: String
        let profession: String
        let personality: String
        let role: Role

        enum Role: String {
            case hero = "heroe"
            case villain = "villano"
            case neutral = "neutro"
        }
    }
    
    enum Length: String {
        case words
        case paragraphs
    }

    enum Stage: String {
        case baby = "bebé"
        case preschooler = "preescolar"
        case child = "infante"
        case preteenager = "preadolescente"
        case teenager = "adolescente"
    }
}
