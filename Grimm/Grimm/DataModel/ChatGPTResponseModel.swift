//
//  ChatGPTResponseModel.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 19/03/24.
//
struct ChatGPTResponseModel: Decodable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let systemFingerprint: String?
    let choices: [Choices]?
    let usage: Usage?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case created = "created"
        case model = "model"
        case systemFingerprint = "system_fingerprint"
        case choices = "choices"
        case usage = "usage"
    }
    
    struct Usage: Decodable {
        let promptTokens: Int?
        let completionTokens: Int?
        let totalTokens: Int?
        
        enum UsageKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
    
    struct Choices: Decodable {
        let index: Int?
        let message: MessageResponse?
        let logprobs: String?
        let finishReason: String?
        
        enum ChoicesKeys: String, CodingKey {
            case index = "index"
            case message = "message"
            case logprobs = "logprobs"
            case finishReason = "finish_reason"
        }
        
        struct MessageResponse: Decodable {
            var role: String?
            var content: String?
            
            enum MessageResponse: String, CodingKey {
                case role = "role"
                case content = "content"
            }
        }
    }
}
