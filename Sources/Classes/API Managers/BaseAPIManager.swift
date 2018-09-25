//
//  BaseAPIManager.swift
//  ScryfallSwift
//
//  Created by Oleksandr Rudavka on 2018-09-21.
//
import Foundation


enum HTTPMethod: String {
    case get, post, put, delete
}


enum Endpoint: String {
    static let base = "api.scryfall.com"
    
    case allSets = "/sets"
    case grnSet = "/sets/grn"
}


enum Response {
    case success(Data)
    case failure(Error)
}


struct Request {
    var endpoint: Endpoint
    var headers: [String: String]?
    var parameters: [String: String]?
    var body: Data?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    var url: URL {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = Endpoint.base
            components.path = self.endpoint.rawValue
            
            components.queryItems = parameters?.compactMap { URLQueryItem(name: $0, value: $1) }
            
            return components.url!
        }
    }
    
    var urlRequest: URLRequest {
        get {
            var request = URLRequest(url: self.url)
            
            request.allHTTPHeaderFields = self.headers
            request.httpBody = self.body
            request.httpMethod = HTTPMethod.get.rawValue
            
            return request
        }
    }
}


class BaseAPIManager: NSObject {
    static func performRequest(request: Request, completion: @escaping (Response) -> ()) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request.urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = ScryfallError.init(status: 404, code: "", details: "Server returned empty data.", type: nil, warnings: nil)
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
            
        }
        dataTask.resume()
    }
}
