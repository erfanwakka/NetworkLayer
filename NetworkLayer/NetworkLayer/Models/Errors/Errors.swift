//
//  Errors.swift
//  NetworkLayer
//
//  Created by Erfan Andesta on 12/14/20.
//

import Foundation

enum HTTPStatusCodes: Int {
    case success = 200
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case serverError = 500
    case unAvailable = 503
    
}
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
    
    var defaultMessage: String {
        switch self {
        case .badRequest: return "Bad request"
        case .unAuthorized: return "You are not authorized"
        case .forbidden: return "You are not allowed"
        case .serverError: return "Server error occured"
        case .unAvailable: return "Server is under maintanance"
        case .error(let message): return message
        }
    }
    
    func errorMessage() -> String {
        switch self {
        case .badRequest(let data), .forbidden(let data), .serverError(let data), .unAuthorized(let data), .unAvailable(let data):
            if let data = data, let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data), let message = errorModel.message {
                return message
            } else {
                return defaultMessage
            }
        case .error(let message):
            return message
        }
    }
}
