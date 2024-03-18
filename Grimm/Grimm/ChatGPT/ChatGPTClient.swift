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
            "model": "gpt-3.5-turbo",
            "messages": [
              [
                "role": "system",
                "content": "Eres un ayudante muy útil"
              ],
              [
                "role": "user",
                "content": prompt
              ]
            ]
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
        print("---------- URL ----------")
        print(request.url ?? "NO URL FOUND")
        print("-------------------------")
        print("-------- HEADERS --------")
        print(request.allHTTPHeaderFields ?? "NO HEADER FOUND")
        print("-------------------------")
        print("-------- METHOD ---------")
        print(request.httpMethod ?? "NO HTTP METHOD FOUND")
        print("-------------------------")
        print("---------- BODY ---------")
        print(request.httpBody ?? "NO BODY FOUND")
        print("-------------------------")
        let response = try await URLSession.shared.data(for: request)
        if let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("----- RESPONSE CODE -----")
            print(httpResponse)
            print("-------------------------")
            if let json = try JSONSerialization.jsonObject(with: response.0, options: .fragmentsAllowed) as? [String: Any] {
                print("---------- JSON ---------")
                print(json)
                print("-------------------------")
            } else {
                print("---------- JSON ---------")
                print("COULD NOT DECODE JSON")
                print("-------------------------")
            }
        } else {
            print("----- RESPONSE CODE -----")
            print("NO RESPONSE CODE FOUND")
            print("-------------------------")
        }
    }
}
