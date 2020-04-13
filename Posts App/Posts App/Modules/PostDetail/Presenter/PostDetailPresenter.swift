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
        self.selectedPost?.read = true
        guard let selectedPost = self.selectedPost else { return }
        view?.displayPostData(post: selectedPost)
        interactor?.fetchUser(userId: selectedPost.userId)
        interactor?.fetchPostComments(postId: selectedPost.id)
        interactor?.updatePost(post: selectedPost)
    }
    
    func favoriteButtonTapped(favoriteState: Bool) {
        self.selectedPost?.favorite = favoriteState
        guard let selectedPost = self.selectedPost else { return }
        interactor?.updatePost(post: selectedPost)
    }
}

extension PostDetailPresenter: PostDetailInteractorOutputProtocol {
    func fetchedUserSuccess(userModel: PostDetailModel.User) {
        view?.displayUserData(user: userModel)
    }
    
    func fetchedUserFailure(errorMessage: String) {
        view?.showErrorAlert(errorMessage: errorMessage)
    }
    
    func fetchedPostCommentsSuccess(commentsModel: [PostDetailModel.Comment]) {
        view?.displayPostCommentsData(postComments: commentsModel)
    }
    
    func fetchedPostCommentsFailure(errorMessage: String) {
        view?.showErrorAlert(errorMessage: errorMessage)
    }
    
    func updatePostCoreDataFailure(errorMessage: String) {
        view?.showErrorAlert(errorMessage: errorMessage)
    }
}
