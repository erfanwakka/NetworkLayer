//
//  ErrorModel.swift
//  NetworkLayer
//
//  Created by Erfan Andesta on 12/14/20.
//

import Foundation

enum Errors: Error, LocalizedError {
    case badRequest
    case serverError
    case unAuthorized
    case forbidden
    case unavailable
}
class ErrorModel: Error {
    var localizedDescription: String = ""
}
