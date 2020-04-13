//
//  PostsListPresenter.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostsListPresenter: PostsListPresenterProtocol {
    weak var view: PostsListViewProtocol?
    var router: PostsListRouterProtocol?
    var interactor: PostsListInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.fetchSavedPostsList()
    }
    
    func viewWillAppear() {
        interactor?.fetchSavedPostsList()
    }
    
    func didSelectPost(selectedPost: PostsListModel.Post) {
        let selectedPost = PostDetailModel.Post(userId: selectedPost.userId,
                                                id: selectedPost.id,
                                                title: selectedPost.title,
                                                body: selectedPost.body,
                                                read: selectedPost.read,
                                                favorite: selectedPost.favorite)
        router?.goToPostDetail(selectedPost: selectedPost)
    }
    
    func deleteAllButtonTapped() {
        interactor?.deleteAllPostsCoreData()
    }
    
    func deletePost(postId: Int) {
        interactor?.deletePostCoreData(postId: postId)
    }
    
    func reloadButtonTapped() {
        interactor?.fetchPosts()
    }
}

extension PostsListPresenter: PostsListInteractorOutputProtocol {
    func fetchedPostsSuccess(model: [PostsListModel.Post]) {
        view?.displayPostsList(model: model)
    }
    
    func fetchedPostsFailure(errorMessage: String) {
        
    }
}
