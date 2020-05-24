//
//  NetworkManager.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

enum Endpoint {
    case getBreeds
    case getImages(limit: Int, cursor: Int)
    case getImageById(id: String)
    
    var parameters: String {
        switch self {
        case .getBreeds:
            return "breeds"
        case .getImages(let limit, let cursor):
            return "images/search?limit=\(limit)&page=\(cursor)&order=DESC"
        case .getImageById(let id):
            return "images/search?breed_ids=\(id)&limit=1"
        }
    }
}

var imageCache = NSCache<NSString, UIImage>()

class NetworkManager {
    
    private let urlBase = "https://api.thecatapi.com/v1/"
    
    private func createRequest(endpoint: String) -> URLRequest {
        let url = URL(string: endpoint)
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func getData<T: Decodable>(target: Endpoint, completion: @escaping (Result<[T], ApiResponse>) -> Void) {
        
        let url = urlBase + target.parameters
        let request = createRequest(endpoint: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                completion(.failure(.failed))
                return
            }
            do {
                let res = try JSONDecoder().decode(Array<T>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            }
            catch {
                completion(.failure(.failed))
            }
        }
        task.resume()
    }
}

