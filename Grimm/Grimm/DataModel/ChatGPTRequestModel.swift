//
//  ChatGPTRequestModel.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 19/03/24.
//

struct ChatGPTRequestModel: Encodable {
    var model: ChatGPTModels
    var messages: [Message]
    
    enum CodingKeys: String, CodingKey {
        case model = "model"
        case messages = "messages"
    }
    
    enum ChatGPTModels: String {
        case gpt_3_5_turbo = "gpt-3.5-turbo"
    }
    
    struct Message: Encodable {
        var role: Role
        var content: Content
        
        enum Role: String, Encodable {
            case system
            case user
        }
        
        enum Content: Encodable {
            case userPrompt(String)
            case storyTeller(String = "you are a professional writer, dedicated to create tales for children, with a profound understanding of how to deliver fun and education to your infant public.")
        }
        
        enum MessageCodingKeys: String, CodingKey {
            case role = "role"
            case content = "content"
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.rawValue, forKey: .model)
        
        var messagesContainer = container.nestedUnkeyedContainer(forKey: .messages)
        for message in messages {
            var messageContainer = messagesContainer.nestedContainer(keyedBy: Message.MessageCodingKeys.self)
            try messageContainer.encode(message.role.rawValue, forKey: .role)
            switch message.content {
            case .storyTeller(let content):
                try messageContainer.encode(content, forKey: .content)
            case .userPrompt(let prompt):
                try messageContainer.encode(prompt, forKey: .content)
            }
        }
    }
}
