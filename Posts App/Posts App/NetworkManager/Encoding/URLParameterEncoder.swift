//
//  URLParameterEncoder.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        let convertedParameters = parameters.mapValues { (value) -> Any in
            if (value as? NSNumber) === kCFBooleanTrue {
                return true
            } else if (value as? NSNumber) === kCFBooleanFalse {
                return false
            }
            return value
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in convertedParameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
