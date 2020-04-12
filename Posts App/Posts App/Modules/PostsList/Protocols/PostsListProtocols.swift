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
}

protocol PostsListPresenterProtocol {
    func viewDidLoad()
}

protocol PostsListInteractorOutputProtocol: class {
    func fetchedPostsSuccess(model: [PostsListModel.Post])
    func fetchedPostsFailure(errorMessage: String)
}

protocol PostsListRouterProtocol {
    
}

protocol PostsListViewProtocol: class {
    func displayPostsList(mdoel: [PostsListModel.Post])
}
