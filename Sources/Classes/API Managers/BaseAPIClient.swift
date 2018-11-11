//
//  BaseAPIClient.swift
//  ScryfallSwift
//
//  Created by Oleksandr Rudavka on 2018-09-21.
//
import Foundation

typealias ImageConfig = (isBackFace: Bool, version: Imagery.CodingKeys)
enum Format {
    case json, text
    case image(ImageConfig)
    
    func stringRepresentation() -> String {
        switch self {
        case .json:
            return "json"
        case .text:
            return "text"
        case .image( _):
            return "image"
        }
    }
}
extension Format: QueryableAPIRequest {
    var queryItems: [String : String] {
        var format = [String: String]()
        switch self {
        case .image(let config):
            format["face"] = config.isBackFace ? "back" : nil
            format["version"] = config.version.stringValue
        default:
            break
        }
        format["format"] = self.stringRepresentation()
        return format
    }
}


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
            
            // Make sure there is data associated with response.
            guard let data = data else {
                let error = ScryfallError.init(status: 404, code: "", details: "Server returned empty data.", type: nil, warnings: nil)
                completion(.failure(error))
                return
            }
            
            // If request didn't fail but instead server returned 'internal' error
            if let error = try? JSONDecoder().decode(ScryfallError.self, from: data) {
                completion(.failure(error))
                return
            }
            
            // If response should be of type Data - don't decode it into json, simply return.
            if R.Response.self == Data.self {
                let data = data as! R.Response
                completion(.success(data))
                return
            }
            
            // If response should be of type String - don't decode it into json, return as String
            if R.Response.self == String.self {
                let string = String(data: data, encoding: .utf8) as! R.Response
                completion(.success(string))
                return
            }
            
            do {
                let encodedResponse = try JSONDecoder().decode(R.Response.self, from: data)
                completion(.success(encodedResponse))
            } catch {
                print(error)
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
        var urlRequest          = URLRequest(url: url)
        
        if let customHTTPRequest = request as? CustomHTTPRequest {
            urlRequest.httpMethod = customHTTPRequest.httpMethod.rawValue
        } else {
            urlRequest.httpMethod   = HTTPMethod.get.rawValue
        }
        
        if let customBodyRequest = request as? CustomBodyRequest {
            urlRequest.httpBody = customBodyRequest.body
        }
        
        if let customHeadersRequest = request as? CustomHeadersRequest {
            urlRequest.allHTTPHeaderFields = customHeadersRequest.headers
        }
        
        
        return urlRequest
    }
}
