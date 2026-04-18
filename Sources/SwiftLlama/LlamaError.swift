//
//  LlamaError.swift
//  swift-llama-cpp
//
//  Created by Piotr Gorzelany on 30/07/2025.
//

import Foundation

public enum LlamaError: Error {
    case couldNotInitializeContext
    case contextSizeLimitExeeded
    case decodingError
    case emptyMessageArray
}

extension LlamaError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .couldNotInitializeContext:
            return "Failed to initialize the Llama context. The model file may be corrupt or too large for available memory."
        case .contextSizeLimitExeeded:
            return "The prompt exceeded the model's context window. Start a new conversation or reduce the input size."
        case .decodingError:
            return "The Llama runtime failed to decode the prompt or produce a token. Retrying may succeed; if not, restart the app to reload the model."
        case .emptyMessageArray:
            return "No messages were provided to generate a completion from."
        }
    }
}
