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
    
}

extension PostDetailPresenter: PostDetailInteractorOutputProtocol {
    
}
