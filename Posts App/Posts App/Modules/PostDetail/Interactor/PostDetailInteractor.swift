//
//  PostDetailInteractor.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostDetailInteractor: PostDetailInteractorProtocol {
    weak var presenter: PostDetailInteractorOutputProtocol?
    var usersNetworkManager: UsersNetworkManagerProtocol?
    var postsNetworkManager: PostsNetworkManagerProtocol?
    
    init(usersNetworkManager: UsersNetworkManagerProtocol = UsersNetworkManager(),
         postsNetworkManager: PostsNetworkManagerProtocol = PostsNetworkManager()) {
        self.usersNetworkManager = usersNetworkManager
        self.postsNetworkManager = postsNetworkManager
    }
    
    func fetchUser(userId: Int) {
        let request = GetUserUseCase.Request(id: userId)
        usersNetworkManager?.getUser(request: request, completion: { [weak self] (response) in
            switch response {
            case .success(let data):
                guard let user = data.first else { return }
                let userModel = PostDetailModel.User(name: user.name, email: user.email, phone: user.phone, website: user.website)
                self?.presenter?.fetchedUserSuccess(userModel: userModel)
            case .failure(let error):
                self?.presenter?.fetchedUserFailure(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func fetchPostComments(postId: Int) {
        let request = GetPostCommentsUseCase.Request(postId: postId)
        postsNetworkManager?.getPostComments(request: request, completion: { [weak self] (response) in
            switch response {
            case .success(let data):
                let commentsModel = data.map({
                    PostDetailModel.Comment(postId: $0.postId, id: $0.id, name: $0.name, email: $0.email, body: $0.body)
                })
                self?.presenter?.fetchedPostCommentsSuccess(commentsModel: commentsModel)
            case .failure(let error):
                self?.presenter?.fetchedPostCommentsFailure(errorMessage: error.localizedDescription)
            }
        })
    }
}
