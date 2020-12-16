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
                if response.statusCode != 200 {
                    switch response.statusCode {
                    case 400:
                        completion(.failure(.badRequest(data)))
                    case 401:
                        completion(.failure(.unAuthorized(data)))
                    case 403:
                        completion(.failure(.forbidden(data)))
                    case 503:
                        completion(.failure(.unAvailable(data)))
                    case 500:
                        completion(.failure(.serverError(data)))
                    default:
                        break
                    }
                }
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(Errors.error(error.localizedDescription)))
                }
            } else {
                completion(.failure(Errors.error("No data Provided")))
            }
        }
    }
}
