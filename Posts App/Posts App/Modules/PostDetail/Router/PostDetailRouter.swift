//
//  PostDetailRouter.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

class PostDetailRouter: PostDetailRouterProtocol {
    weak var viewController: BaseViewController?
    
    static func createModule() -> PostDetailViewController {
        let ref = PostDetailViewController.instantiate(from: .PostDetail)
        let presenter = PostDetailPresenter()
        
        let router = PostDetailRouter()
        router.viewController = ref
        
        let interactor = PostDetailInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
}
