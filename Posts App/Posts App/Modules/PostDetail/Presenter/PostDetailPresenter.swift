//
//  PostDetailPresenter.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostDetailPresenter: PostDetailPresenterProtocol {
    weak var view: PostDetailViewProtocol?
    var router: PostDetailRouterProtocol?
    var interactor: PostDetailInteractorProtocol?
    
    var selectedPost: PostDetailModel.Post?
    
    func viewDidLoad() {
        guard var selectedPost = self.selectedPost else { return }
        view?.displayPostData(post: selectedPost)
        interactor?.fetchUser(userId: selectedPost.userId)
        interactor?.fetchPostComments(postId: selectedPost.id)
        selectedPost.read = true
        interactor?.updatePost(post: selectedPost)
    }
}

extension PostDetailPresenter: PostDetailInteractorOutputProtocol {
    func fetchedUserSuccess(userModel: PostDetailModel.User) {
        view?.displayUserData(user: userModel)
    }
    
    func fetchedUserFailure(errorMessage: String) {
        
    }
    
    func fetchedPostCommentsSuccess(commentsModel: [PostDetailModel.Comment]) {
        view?.displayPostCommentsData(postComments: commentsModel)
    }
    
    func fetchedPostCommentsFailure(errorMessage: String) {
        
    }
}
