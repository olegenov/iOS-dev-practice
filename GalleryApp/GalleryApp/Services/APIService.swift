//
//  APIService.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import Foundation

class ApiService {
    let url: URL
    let param: String
    
    init(url: URL, param: String) {
        self.url = url
        self.param = param
    }
    
    func fetchImage(completion: @escaping (String?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                completion(nil)
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let jsonDict = jsonObject as? [String: Any],
                   let extractedParam = jsonDict[self.param] as? String {
                    completion(extractedParam)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
