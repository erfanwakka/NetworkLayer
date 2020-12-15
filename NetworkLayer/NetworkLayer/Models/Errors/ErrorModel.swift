//
//  ErrorModel.swift
//  NetworkLayer
//
//  Created by Erfan Andesta on 12/14/20.
//

import Foundation

enum Errors: Error, LocalizedError {
    case badRequest(message: String = "")
    case forbidden(message: String = "")
    case error(message: String = "")
    case serverError
    case unAuthorized
    case unavailable
    
    func handleError() {
        //TODO: - depend on error show some alerts -
    }
    func 
}
