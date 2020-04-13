//
//  PostDetailModel.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct PostDetailModel {
    struct Post {
        var userId: Int
        var id: Int
        var title: String
        var body: String
        var read: Bool
        var favorite: Bool
    }
    
    struct User {
        var name: String
        var email: String
        var phone: String
        var website: String
    }
    
    struct Comment {
        var postId: Int
        var id: Int
        var name: String
        var email: String
        var body: String
    }
}
