//
//  NetworkService.swift
//  Images
//
//  Created by Alice Romanova on 20.05.2022.
//

import Foundation

// Реализация построения запроса URL

class NetworkService {
    
    
    func getRequest(request: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParameters(request: request)
        let url = self.setupURL(parameters: parameters)
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = setupKey()
        request.httpMethod = "get"
        
        let task = createDataTask(request: request, completion: completion)
        task.resume()
    }
    
    private func setupKey() -> [String: String]? {
        var keys = [String: String]()
        keys["Authorization"] = "Client-ID UUuAKCIUW06o6kMH-tbCEk7efJFMwtl8_aE6c_uh8ZM"
        
        return keys
    }
    
    private func prepareParameters(request: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = request
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        
        return parameters
    }
    
    private func setupURL(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = ""
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
    }
    
}


