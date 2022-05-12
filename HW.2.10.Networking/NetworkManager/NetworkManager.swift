//
//  NetworkManager.swift
//  HW.2.10.Networking
//
//  Created by Sergey Yurtaev on 30.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
     
    func fetchData(from urlString: String, with complition: @escaping ([Planets]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let planets = try JSONDecoder().decode([Planets].self, from: data)
                complition(planets)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
}



