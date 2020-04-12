//
//  PostDetailViewController.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

class PostDetailViewController: BaseViewController {
    
    var presenter: PostDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension PostDetailViewController: PostDetailViewProtocol {
    
}
