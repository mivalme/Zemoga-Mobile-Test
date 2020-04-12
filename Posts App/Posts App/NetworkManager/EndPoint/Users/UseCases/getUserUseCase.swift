//
//  GetUserUseCase.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct GetUserUseCase {
    struct Request: Codable {
        var id: Int
    }
    
    typealias Response = [User]
    
    struct User: Codable {
        var name: String
        var email: String
        var phone: String
        var website: String
    }
}
