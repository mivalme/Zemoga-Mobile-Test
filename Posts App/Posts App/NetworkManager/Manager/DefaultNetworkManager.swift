//
//  DefaultNetworkManager.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum PostsAppResult<T> {
    case success(T)
    case failure(Error)
}

enum ServiceResult {
    case success
    case failure(Error)
}

class DefaultNetworkManager {
    enum DefaultErrorType: String, Error {
        case notDecodeData = "Data is Nil"
        case notParseData = "Error parsing data"
        case serverFail = "Connection error with server"
        case unauthorized = "You are unauthorized to execute this service"
        case notFound = "Service is not found"
    }
    
    func load<T: Decodable> (data: Data?, as type: T.Type = T.self) throws -> T {
        guard let data = data else { throw DefaultErrorType.notDecodeData }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DefaultErrorType.notParseData
        }
    }
    
    func handleNetwork(_ response: HTTPURLResponse) -> ServiceResult {
        switch response.statusCode {
        case 200...299: return .success
        case 401: return .failure(DefaultErrorType.unauthorized)
        case 404: return .failure(DefaultErrorType.notFound)
        default: return .failure(DefaultErrorType.serverFail)
        }
    }
}
