//
//  PostsListInteractor.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostsListInteractor: PostsListInteractorProtocol {
    weak var presenter: PostsListInteractorOutputProtocol?
    var postsNetworkManager: PostsNetworkManagerProtocol?
    
    init(postsNetworkManager: PostsNetworkManagerProtocol = PostsNetworkManager()) {
        self.postsNetworkManager = postsNetworkManager
    }
    
    func fetchPosts() {
        postsNetworkManager?.getPosts(completion: { [weak self] (response) in
            switch response {
            case .success(let response):
                var model = [PostsListModel.Post]()
                response.forEach({
                    let post = PostsListModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
                    model.append(post)
                })
                self?.presenter?.fetchedPostsSuccess(model: model)
            case .failure(let error):
                self?.presenter?.fetchedPostsFailure(errorMessage: error.localizedDescription)
            }
        })
    }
}
