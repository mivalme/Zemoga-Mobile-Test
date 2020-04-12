//
//  PostsListRouter.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostsListRouter: PostsListRouterProtocol {
    weak var viewController: BaseViewController?
    
    static func createModule() -> PostsListViewController {
        let ref = PostsListViewController.instantiate(from: .PostsList)
        let presenter = PostsListPresenter()
        
        let router = PostsListRouter()
        router.viewController = ref
        
        let interactor = PostsListInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
}
