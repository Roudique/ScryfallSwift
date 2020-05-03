//
//  BaseAPIClient.swift
//  ScryfallSwift
//
//  Created by Oleksandr Rudavka on 2018-09-21.
//
import Foundation

public typealias ImageConfig = (isBackFace: Bool, version: Imagery.CodingKeys)
public enum Format {
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
    public var queryItems: [String : String] {
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


public enum HTTPMethod: String {
    case get, post, put, delete
}


public enum Response<ScryfallData> {
    case success(ScryfallData)
    case failure(Error)
}


public enum BaseAPIClientError: Error {
    case couldNotEncodeString
}


public class BaseAPIClient: NSObject {
    private let host = "api.scryfall.com"
    private let session = URLSession(configuration: .default)
    
    public var debugLogLevel = true
    public var completionQueue: DispatchQueue = DispatchQueue.main
    
    @discardableResult
    public func send<R: APIRequest>(
        request: R,
        completion: @escaping (Response<R.Response>) -> ()) -> Cancellable? {
        return send(request: request, cached: nil, withoutPagination: false, completion: completion)
    }
    
    @discardableResult
    public func send<R: APIRequest>(
        request: R,
        withoutPagination: Bool,
        completion: @escaping (Response<R.Response>) -> ()) -> Cancellable? {
        return send(request: request, cached: nil, withoutPagination: withoutPagination, completion: completion)
    }
    
    @discardableResult
    private func send<R: APIRequest>(
        request: R,
        cached: [Decodable]?,
        withoutPagination: Bool,
        completion: @escaping (Response<R.Response>) -> ()) -> Cancellable? {
        guard var urlRequest = self.urlRequest(for: request) else {
            completionQueue.async { completion(Response.failure(CommonError.invalidURL(request.resourceName))) }
            return nil
        }
        
        if let basicRequest = request as? BasicAPIRequest, let basicURL = basicRequest.basicURL {
            urlRequest = URLRequest(url: basicURL)
        }
        
        if debugLogLevel { print("request url: \(urlRequest.url!)") }
        
        let dataTask = self.session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain,
                nsError.code == -999 {
                    return
                }
                
                self.completionQueue.async { completion(.failure(error)) }
                return
            }
            
            // Make sure there is data associated with response.
            guard let data = data else {
                let error = ScryfallError.init(status: 404, code: "", details: "Server returned empty data.", type: nil, warnings: nil)
                self.completionQueue.async { completion(.failure(error)) }
                return
            }
            
            // If request didn't fail but instead server returned 'internal' error
            if let error = try? JSONDecoder().decode(ScryfallError.self, from: data) {
                self.completionQueue.async { completion(.failure(error)) }
                return
            }
            
            //TODO: Fix this. Combine with other handling of Data and String.
            if request is FormatResponseRequest {
                let formattedResponseRequest = request as! FormatResponseRequest
                switch formattedResponseRequest.format {
                case .text:
                    guard let string = String(data: data, encoding: .utf8) else {
                        self.completionQueue.async { completion(.failure(BaseAPIClientError.couldNotEncodeString)) }
                        return
                    }
                    let result = FormatResponse.text(string) as! R.Response
                    self.completionQueue.async { completion(.success(result)) }
                    return
                case .image(_):
                    let result = FormatResponse.data(data) as! R.Response
                    self.completionQueue.async { completion(.success(result)) }
                    return
                default:
                    break
                }
            }
            
            // If response should be of type Data - don't decode it into json, simply return.
            if R.Response.self == Data.self {
                let data = data as! R.Response
                self.completionQueue.async { completion(.success(data)) }
                return
            }
            
            // If response should be of type String - don't decode it into json, return as String
            if R.Response.self == String.self {
                let string = String(data: data, encoding: .utf8) as! R.Response
                self.completionQueue.async { completion(.success(string)) }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let encodedResponse = try decoder.decode(R.Response.self, from: data)

                if withoutPagination, let list = encodedResponse as? List<Card>, list.nextPage != nil || cached != nil {
                    var cards = list.data

                    if let cachedCards = cached as? [Card] {
                        cards = cachedCards + cards
                        list.data = cachedCards + list.data
                    }
                    
                    if let nextPageURL = list.nextPage {
                        let basicRequest = FulltextCardSearchRequest(basicURL: nextPageURL)
                        
                        self.send(request: basicRequest, cached: cards, withoutPagination: true, completion: completion as! (Response<List<Card>>) -> ())
                        return
                    }
                }
                
                self.completionQueue.async { completion(.success(encodedResponse)) }
            } catch {
                if self.debugLogLevel { print(error) }
                self.completionQueue.async { completion(.failure(error)) }
            }
            
        }
        
        dataTask.resume()
        return dataTask
    }
    
    public func url<T: APIRequest>(for request: T) -> URL? {
        return urlRequest(for: request)?.url
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
