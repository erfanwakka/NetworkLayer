//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by erfan on 9/25/1399 AP.
//

import Foundation

class NetworkManager {
    
    private init() {}
    static let shared = NetworkManager()
    
    func request<T: Encodable>(request: URLRequest, completion: @escaping (Swift.Result<T, Errors>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(message: error.localizedDescription)))
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    switch response.statusCode {
                    case 500:
                        completion(.failure(.serverError)))
                    case 400:
                        completion(.failure(.badRequest(message: response))))
                    default:
                        <#code#>
                    }
                }
            }
        }
    }
    
    
}
