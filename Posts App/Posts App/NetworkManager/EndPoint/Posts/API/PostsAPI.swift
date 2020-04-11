//
//  PostsAPI.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum PostsAPI {
    case getPosts
    case getPostComments(GetPostCommentsUseCase.Request)
}

extension PostsAPI: EndPointType {
    var path: String {
        let subPath = "/posts"
        switch self {
        case .getPosts:
            return subPath
        case .getPostComments(let request):
            return subPath + "/\(request.postId)/comments"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPosts, .getPostComments:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getPosts, .getPostComments:
            return .request
        }
    }
}
