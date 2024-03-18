//
//  ChatGPTClient.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import Foundation

class ChatGPTClient {
    var prompt = ""
    private let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    private var parameters: [String: Any] { [
        "prompt": prompt,
        "max_tokens": 1000,
        "temperature": 0.5,
        "frequency_penalty": 0.5,
        "presence_penalty": 0.5,
        "stop": ["\n"]
    ] }
    private var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        return request
    }
    
    func generateText() async throws {
        dump(request)
        let response = try await URLSession.shared.data(for: request)
        if let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 {
            if let json = try JSONSerialization.jsonObject(with: response.0, options: .fragmentsAllowed) as? [String: Any] {
                print(json)
            }
        }
    }
}
