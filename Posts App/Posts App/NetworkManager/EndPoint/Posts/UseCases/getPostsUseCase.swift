//
//  getPostsUseCase.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct GetPostsUseCase {
    typealias Response = [Post]
    
    struct Post: Codable {
        var userId: Int
        var id: Int
        var title: String
        var body: String
    }
}
