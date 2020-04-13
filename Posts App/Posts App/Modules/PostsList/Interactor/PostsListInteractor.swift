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
                response.forEach({
                    let post = PostsListModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
                    model.append(post)
                })
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
                        PostsListModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
                    })
                    self?.presenter?.fetchedPostsSuccess(model: postsListModel)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func savePostsCoreData(postsList: [PostsListModel.Post]) {
        let postsModel = postsList.map({
            CoreDataModel.Post(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
        })
        coreDataManager?.savePostsList(postsModel: postsModel, completion: { (response) in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                break
            }
        })
    }
}
