//
//  UsersAPI.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum UsersAPI {
    case getUser(request: GetUserUseCase.Request)
}

extension UsersAPI: EndPointType {
    var path: String {
        let subPath = "/users"
        switch self {
        case .getUser:
            return subPath
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getUser(let parameters):
            return .requestWithParameters(parameters: parameters.dictionary())
        }
    }
}
