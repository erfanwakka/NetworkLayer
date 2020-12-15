//
//  RequestModel.swift
//  NetworkLayer
//
//  Created by Erfan Andesta on 12/14/20.
//

import Foundation

class EmptyBody: Encodable {}

protocol Route {
    var path: String { get }
}
enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELTE"
}
protocol RequestModel {
    associatedtype Body: Encodable
    var path: String { get }
    var parameters: [String: Any?] { get }
    var headers: [String: String] { get }
    var method: HTTPRequestMethod { get }
    var body: Body? { get set }
}
extension RequestModel {
    var headers: [String: String] {
        get {
            return [:]
        }
    }
    var parameters: [String: Any?] {
        get {
            return [:]
        }
    }
    var method: HTTPRequestMethod {
        get {
            return .get
        }
    }
    
    func urlRequest() -> URLRequest {
        
        let url = URL(string: Constants.endPoint)!
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            if let value = value as? String {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
        }
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch let error {
            print("Could not encode body: \(error.localizedDescription)")
        }
        
        return request
    }
}
