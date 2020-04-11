//
//  Router.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
        } catch {
            DispatchQueue.main.async {
                completion(nil, nil, error)
            }
        }
        self.task?.resume()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task{
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParameters(let parameters):
                try self.configureParameters(parameters: parameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(parameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let parameters = parameters, let httpMethod = request.httpMethod {
                switch httpMethod {
                case HTTPMethod.get.rawValue:
                    try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
                case HTTPMethod.post.rawValue:
                    try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
                default:
                    break
                }
            } else {
                throw NetworkError.parametersNil
            }
        } catch {
            throw error
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
