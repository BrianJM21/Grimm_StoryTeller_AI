//
//  ChatGPTAPIClient.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import Foundation

class ChatGPTAPIClient {
    private let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    private let encoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    private func buildHttpRequest(with requestModel: ChatGPTRequestModel) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(requestModel)
        return request
    }
    
    func generateTextWithPrompt(_ prompt: String) async throws -> String {
        let requestModel = ChatGPTRequestModel(model: .gpt_3_5_turbo,
                                               messages: [ChatGPTRequestModel.Message(role: .system,
                                                                                      content: .storyTeller()),
                                                          ChatGPTRequestModel.Message(role: .user,
                                                                                      content: .userPrompt(prompt))
                                               ])
        let httpRequest = try buildHttpRequest(with: requestModel)
        print("---------- URL ----------")
        print(httpRequest.url ?? "NO URL FOUND")
        print("-------------------------")
        print("-------- HEADERS --------")
        print(httpRequest.allHTTPHeaderFields ?? "NO HEADER FOUND")
        print("-------------------------")
        print("-------- METHOD ---------")
        print(httpRequest.httpMethod ?? "NO HTTP METHOD FOUND")
        print("-------------------------")
        print("---------- BODY ---------")
        print(String(data: httpRequest.httpBody ?? Data(), encoding: .utf8) ?? "NO BODY FOUND")
        print("-------------------------")
        let response = try await URLSession.shared.data(for: httpRequest)
        if let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("----- RESPONSE CODE -----")
            print(httpResponse.statusCode)
            print("-------------------------")
            if let json = try JSONSerialization.jsonObject(with: response.0, options: .mutableContainers) as? [String: Any] {
                print("----- RESPONSE JSON -----")
                print(json)
                print("-------------------------")
                let responseModel = try JSONDecoder().decode(ChatGPTResponseModel.self, from: response.0)
                if let textResponse = responseModel.choices?.first?.message?.content {
                    return textResponse
                }
            } else {
                print("---------- JSON ---------")
                print("INVALID JSON IN DECODE")
                print("-------------------------")
                throw ChatGPTAPIClientError.jsonDecode
            }
        } else {
            print("----- RESPONSE CODE -----")
            print("NO 200 STATUS CODE RESPONSE")
            print("-------------------------")
            throw ChatGPTAPIClientError.statusCode
        }
        print("------ NO RESPONSE ------")
        print("COULD NOT GET RESPONSE")
        print("-------------------------")
        throw ChatGPTAPIClientError.noResponse
    }
    
    private enum ChatGPTAPIClientError: Error {
        case statusCode
        case noResponse
        case jsonDecode
        
        var errorDescription: String? {
            switch self {
            case .statusCode:
                return NSLocalizedString("Petición incorrecta al comunicarse con el servidor.", comment: "")
            case .noResponse:
                return NSLocalizedString("No se pudo obtener respuesta del servidor.", comment: "")
            case .jsonDecode:
                return NSLocalizedString("Ocurrió un problema al querer decodificar el JSON de respuesta.", comment: "")
            }
        }
    }
}
