//
//  NetworkManager.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class NetworkManager {
    
    private func createRequest(endpoint: String) -> URLRequest {
        let url = URL(string: endpoint)
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func getBreedsWithInfo(completion: @escaping ([BreedModel]?, Error?) -> Void) {
        
        let urlBase = "https://api.thecatapi.com/v1/breeds"
        let request = createRequest(endpoint: urlBase)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let allData = data {
                do {
                    let res = try JSONDecoder().decode(Array<BreedModel>.self, from: allData)
                    print("Decodable cats info")
                    DispatchQueue.main.async {
                        print(res)
                        completion(res, nil)
                    }
                }
                catch (let err) {
                    print(err)
                    completion(nil, err)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getShortBreeds(completion: @escaping ([ShortBreedModel]?, Error?) -> Void) {
        let urlBase = "https://api.thecatapi.com/v1/breeds"
        let request = createRequest(endpoint: urlBase)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let allData = data {
                do {
                    let res = try JSONDecoder().decode(Array<ShortBreedModel>.self, from: allData)
                    print("Decodable cats info")
                    DispatchQueue.main.async {
                        print(res)
                        completion(res, nil)
                    }
                }
                catch (let err) {
                    print(err)
                    completion(nil, err)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getBreedImageById(breedId: String, completion: @escaping ([ShortImageModel]?, Error?) -> Void) {
        
        let urlBase = "https://api.thecatapi.com/v1/images/search?breed_ids=\(breedId)&limit=1"
        let request = createRequest(endpoint: urlBase)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let allData = data {
                do {
                    let res = try JSONDecoder().decode(Array<ShortImageModel>.self, from: allData)
                    print("Decodable image info")
                    DispatchQueue.main.async {
                        print(res)
                        completion(res, nil)
                    }
                }
                catch {
                    print(error)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
    func getFullImageById(imageId: String, completion: @escaping (ShortImageModel?, Error?) -> Void) {
        
        let urlBase = "https://api.thecatapi.com/v1/images/"
        let request = createRequest(endpoint: urlBase)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let allData = data {
                do {
                    let res = try JSONDecoder().decode(ShortImageModel.self, from: allData)
                    print("Decodable image info")
                    DispatchQueue.main.async {
                        print(res)
                        completion(res, nil)
                    }
                }
                catch {
                    print(error)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
    func getImages(limit: Int, cursor: Int, completion: @escaping ([ShortImageModel]?, Error?) -> Void) {
        
        let urlBase = "https://api.thecatapi.com/v1/images/search?limit=\(limit)&page=\(cursor)&order=DESC"
        let request = createRequest(endpoint: urlBase)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let allData = data {
                do {
                    let res = try JSONDecoder().decode(Array<ShortImageModel>.self, from: allData)
                    print("Decodable image info")
                    print(res)
                    if let httpResponse = response as? HTTPURLResponse {
                         if let paginationCount = httpResponse.allHeaderFields["pagination-count"] as? String {
                            print(paginationCount)
                         }
                    }
                    DispatchQueue.main.async {
                        print(res)
                        completion(res, nil)
                    }
                }
                catch {
                    print(error)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}

