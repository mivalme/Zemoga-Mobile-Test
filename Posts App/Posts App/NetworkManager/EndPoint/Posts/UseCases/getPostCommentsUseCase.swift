//
//  getPostCommentsUseCase.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct GetPostCommentsUseCase {
    struct Request: Codable {
        var postId: Int
    }
    
    typealias Response = [Comment]
    
    struct Comment: Codable {
        var postId: Int
        var id: Int
        var name: String
        var email: String
        var body: String
    }
}
