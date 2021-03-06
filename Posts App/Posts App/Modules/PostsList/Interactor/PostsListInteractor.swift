//
//  PostsListInteractor.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit
import CoreData

class PostsListInteractor: PostsListInteractorProtocol {
    weak var presenter: PostsListInteractorOutputProtocol?
    var postsNetworkManager: PostsNetworkManagerProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    
    init(postsNetworkManager: PostsNetworkManagerProtocol = PostsNetworkManager(),
         coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.postsNetworkManager = postsNetworkManager
        self.coreDataManager = coreDataManager
    }
    
    func fetchPosts() {
        postsNetworkManager?.getPosts(completion: { [weak self] (response) in
            switch response {
            case .success(let response):
                var model = [PostsListModel.Post]()
                response.enumerated().forEach({
                    let post = PostsListModel.Post(userId: $0.1.userId,
                                                   id: $0.1.id,
                                                   title: $0.1.title,
                                                   body: $0.1.body,
                                                   read: ($0.0 >= 20),
                                                   favorite: false)
                    model.append(post)
                })
                self?.deleteAllPostsCoreData()
                self?.savePostsCoreData(postsList: model)
                self?.presenter?.fetchedPostsSuccess(model: model)
            case .failure(let error):
                self?.presenter?.fetchedPostsFailure(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func fetchSavedPostsList() {
        coreDataManager?.getPostsList(completion: { [weak self] (response) in
            switch response {
            case .success(let data):
                if data.isEmpty {
                    self?.fetchPosts()
                } else {
                    let postsListModel = data.map({
                        PostsListModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body, read: $0.read, favorite: $0.favorite)
                    })
                    self?.presenter?.fetchedPostsSuccess(model: postsListModel)
                }
            case .failure(let error):
                self?.presenter?.coreDataFailure(errorMessage: error.localizedDescription)
            }
        })
    }
    
    private func savePostsCoreData(postsList: [PostsListModel.Post]) {
        let postsModel = postsList.map({
            CoreDataModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body, read: $0.read, favorite: $0.favorite)
        })
        coreDataManager?.savePostsList(postsModel: postsModel, completion: { [weak self] (response) in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                self?.presenter?.coreDataFailure(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func deleteAllPostsCoreData() {
        coreDataManager?.deleteAllPosts(completion: { [weak self] (response) in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                self?.presenter?.coreDataFailure(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func deletePostCoreData(postId: Int) {
        coreDataManager?.deletePost(postId: postId, completion: { [weak self] (response) in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                self?.presenter?.coreDataFailure(errorMessage: error.localizedDescription)
            }
        })
    }
}
