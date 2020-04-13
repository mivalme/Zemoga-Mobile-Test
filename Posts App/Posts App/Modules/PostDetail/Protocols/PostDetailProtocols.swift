//
//  PostDetailProtocols.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

protocol PostDetailInteractorProtocol {
    func fetchUser(userId: Int)
    func fetchPostComments(postId: Int)
    func updatePost(post: PostDetailModel.Post)
}

protocol PostDetailPresenterProtocol {
    var selectedPost: PostDetailModel.Post? { get set }
    func viewDidLoad()
    func favoriteButtonTapped(favoriteState: Bool)
}

protocol PostDetailInteractorOutputProtocol: class {
    func fetchedUserSuccess(userModel: PostDetailModel.User)
    func fetchedUserFailure(errorMessage: String)
    func fetchedPostCommentsSuccess(commentsModel: [PostDetailModel.Comment])
    func fetchedPostCommentsFailure(errorMessage: String)
}

protocol PostDetailRouterProtocol {
    
}

protocol PostDetailViewProtocol: class {
    func displayPostData(post: PostDetailModel.Post)
    func displayUserData(user: PostDetailModel.User)
    func displayPostCommentsData(postComments: [PostDetailModel.Comment])
}
