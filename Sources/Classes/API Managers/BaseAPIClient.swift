//
//  BaseAPIClient.swift
//  ScryfallSwift
//
//  Created by Oleksandr Rudavka on 2018-09-21.
//
import Foundation


enum HTTPMethod: String {
    case get, post, put, delete
}


enum Response<ScryfallData> {
    case success(ScryfallData)
    case failure(Error)
}


class BaseAPIClient: NSObject {
    private let host = "api.scryfall.com"
    private let session = URLSession(configuration: .default)
    
    func send<R: APIRequest>(request: R, completion: @escaping (Response<R.Response>) -> ()) {
        guard let urlRequest = self.urlRequest(for: request) else {
            completion(Response.failure(CommonError.invalidURL))
            return
        }
        print("request url: \(urlRequest.url!)")
        
        let dataTask = self.session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = ScryfallError.init(status: 404, code: "", details: "Server returned empty data.", type: nil, warnings: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let encodedResponse = try JSONDecoder().decode(R.Response.self, from: data)
                completion(.success(encodedResponse))
            } catch {
                let dataString = String(data: data, encoding: .utf8)!
                print(dataString)
                completion(.failure(error))
            }
            
        }
        dataTask.resume()
    }
    
    private func urlRequest<T: APIRequest>(for request: T) -> URLRequest? {
        var urlComponents       = URLComponents()
        urlComponents.scheme    = "https"
        urlComponents.host      = self.host
        urlComponents.path      = request.resourceName
        
        if let queryableRequest = request as? QueryableAPIRequest {
            urlComponents.queryItems = queryableRequest.queryItems.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url           = urlComponents.url else { return nil }
        var request             = URLRequest(url: url)
        request.httpMethod      = HTTPMethod.get.rawValue
        
        return request
    }
}
