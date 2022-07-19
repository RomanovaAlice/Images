//
//  NetworkDataFetcher.swift
//  Images
//
//  Created by Alice Romanova on 03.06.2022.
//

import Foundation

class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    
    func fetchImages(request: String, completion: @escaping (SearchResults?) -> Void) {
        
        networkService.getRequest(request: request) { data, error in
            if let error = error {
                print("error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, data: data)
            completion(decode)
        }
    }
    
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
