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
    func deleteAllPostsCoreData()
    func deletePostCoreData(postId: Int)
}

protocol PostsListPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectPost(selectedPost: PostsListModel.Post)
    func deleteAllButtonTapped()
    func deletePost(postId: Int)
    func reloadButtonTapped()
}

protocol PostsListInteractorOutputProtocol: class {
    func fetchedPostsSuccess(model: [PostsListModel.Post])
    func fetchedPostsFailure(errorMessage: String)
    func coreDataFailure(errorMessage: String)
}

protocol PostsListRouterProtocol {
    func goToPostDetail(selectedPost: PostDetailModel.Post)
}

protocol PostsListViewProtocol: class {
    func displayPostsList(model: [PostsListModel.Post])
    func showErrorAlert(errorMessage: String)
}
