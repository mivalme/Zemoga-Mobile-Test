//
//  PostsListProtocols.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

protocol PostsListInteractorProtocol {
    func fetchPosts()
    func fetchSavedPostsList()
}

protocol PostsListPresenterProtocol {
    func viewDidLoad()
    func didSelectPost(selectedPost: PostsListModel.Post)
}

protocol PostsListInteractorOutputProtocol: class {
    func fetchedPostsSuccess(model: [PostsListModel.Post])
    func fetchedPostsFailure(errorMessage: String)
}

protocol PostsListRouterProtocol {
    func goToPostDetail(selectedPost: PostDetailModel.Post)
}

protocol PostsListViewProtocol: class {
    func displayPostsList(mdoel: [PostsListModel.Post])
}
