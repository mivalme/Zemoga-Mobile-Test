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
        interactor?.fetchPosts()
    }
}

extension PostsListPresenter: PostsListInteractorOutputProtocol {
    func fetchedPostsSuccess(model: [PostsListModel.Post]) {
        view?.displayPostsList(mdoel: model)
    }
    
    func fetchedPostsFailure(errorMessage: String) {
        
    }
}
