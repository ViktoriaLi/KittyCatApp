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
    
    //
    
    func getBreedsWithInfo(completion: @escaping ([BreedModel]?, Error?) -> Void) {
        
        let urlBase = "https://api.thecatapi.com/v1/breeds"
        
        let url = URL(string: urlBase)
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
        request.allHTTPHeaderFields = headers
        
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
            }
        }
        task.resume()
    }
    
    func getShortBreeds(completion: @escaping ([ShortBreedModel]?, Error?) -> Void) {
        let urlBase = "https://api.thecatapi.com/v1/breeds"
            
        let url = URL(string: urlBase)
            var request = URLRequest(url : url!)
            request.httpMethod = "GET"
            var headers = request.allHTTPHeaderFields ?? [String: String]()
            headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
            request.allHTTPHeaderFields = headers
            
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
                }
            }
            task.resume()
    }
    
    func getBreedImageById(breedId: String, completion: @escaping ([ShortImageModel]?, Error?) -> Void) {
    
    let baseUrl = "https://api.thecatapi.com/v1/images/search?breed_ids=\(breedId)&limit=1"
    guard let url = URL(string: baseUrl) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    var headers = request.allHTTPHeaderFields ?? [String: String]()
    headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
    request.allHTTPHeaderFields = headers
    
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
        
        }
    }.resume()
    }
    
    func getFullImageById(imageId: String, completion: @escaping (ShortImageModel?, Error?) -> Void) {
        
        let baseUrl = "https://api.thecatapi.com/v1/images/"
        guard let url = URL(string: baseUrl + imageId) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
        request.allHTTPHeaderFields = headers
        
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
            
            }
        }.resume()
    }
    
    func getImages(completion: @escaping ([ShortImageModel]?, Error?) -> Void) {
        
        let baseUrl = "https://api.thecatapi.com/v1/images/search?limit=10&page=1&order=DESC"
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["x-api-key"] = "0ed505c5-702b-422b-a136-8098ad7a9c90"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let allData = data {

            do {
                let res = try JSONDecoder().decode(Array<ShortImageModel>.self, from: allData)
                
                       print("Decodable image info")
                print(res)
                DispatchQueue.main.async {
                print(res)
                    completion(res, nil)
                }
            }
            catch {
                print(error)
                completion(nil, error)

            }
            
            }
        }.resume()
    }
}

