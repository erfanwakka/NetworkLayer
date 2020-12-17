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
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Swift.Result<T, Errors>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != HTTPStatusCodes.success.rawValue {
                    switch response.statusCode {
                    case HTTPStatusCodes.badRequest.rawValue:
                        completion(.failure(.badRequest(data)))
                    case HTTPStatusCodes.unAvailable.rawValue:
                        completion(.failure(.unAuthorized(data)))
                    case HTTPStatusCodes.forbidden.rawValue:
                        completion(.failure(.forbidden(data)))
                    case HTTPStatusCodes.unAvailable.rawValue:
                        completion(.failure(.unAvailable(data)))
                    case HTTPStatusCodes.serverError.rawValue:
                        completion(.failure(.serverError(data)))
                    default:
                        completion(.failure(.error("Error with status code: \(response.statusCode)")))
                    }
                }
            } else {
                completion(.failure(Errors.error("No response provided!")))
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(Errors.error(error.localizedDescription)))
                }
            } else {
                completion(.failure(Errors.error("No data provided")))
            }
        }.resume()
    }
}
