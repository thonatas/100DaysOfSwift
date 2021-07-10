//
//  Network.swift
//  Project07
//
//  Created by Thonatas Borges on 03/07/21.
//

import UIKit

class Network {
    
    static let shared = Network()
    private let session = URLSession.shared
    static let urlTopRated = "https://www.hackingwithswift.com/samples/petitions-1.json"
    static let urlMostRecent = "https://www.hackingwithswift.com/samples/petitions-2.json"
    
    func fetch<T: Decodable> (_: T.Type, urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Não foi possível converter a URL", code: 001, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData , timeoutInterval: 60)
        let task = session.dataTask(with: request) { data, response, error in
            //Se não tiver dados:
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    let error = NSError(domain: "Error", code: 001, userInfo: nil)
                    completion(.failure(error))
                }
                return
            }
            //Se tiver dados
            do {
                let decoder = JSONDecoder()
                let objects: T = try decoder.decode(T.self, from: data)
                completion(.success(objects))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
