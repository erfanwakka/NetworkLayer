//
//  Errors.swift
//  NetworkLayer
//
//  Created by Erfan Andesta on 12/14/20.
//

import Foundation

enum Errors: Error, LocalizedError {
    
    case badRequest(_ data: Data?)
    case forbidden(_ data: Data?)
    case error(_ message: String)
    case serverError(_ data: Data?)
    case unAuthorized(_ data: Data?)
    case unAvailable(_ data: Data?)
    
    func handleError() {
        //TODO: - depend on error show some alerts -
    }
    func errorMessage() -> String {
        switch self {
        case .badRequest(let data), .forbidden(let data), .serverError(let data), .unAuthorized(let data), .unAvailable(let data):
            if let data = data, let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data), let message = errorModel.message {
                return message
            } else {
                return "Unknown Error"
            }
        case .error(let message):
            return message
        }
    }
}
