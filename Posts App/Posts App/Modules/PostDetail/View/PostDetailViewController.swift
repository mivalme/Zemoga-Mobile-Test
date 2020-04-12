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
    
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    @IBOutlet private weak var userPhoneLabel: UILabel!
    @IBOutlet private weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    let postCommentCellHeight: CGFloat = 82
    var postCommentsDataSource: [PostDetailModel.Comment]?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setUpTableView()
        self.title = LocalizableStrings.PostDetail.title
    }

}

extension PostDetailViewController: PostDetailViewProtocol {
    func displayPostData(post: PostDetailModel.Post) {
        bodyLabel.text = post.body
    }
    
    func displayUserData(user: PostDetailModel.User) {
        userNameLabel.text = String(format: LocalizableStrings.PostDetail.User.name, user.name)
        userEmailLabel.text = String(format: LocalizableStrings.PostDetail.User.email, user.email)
        userPhoneLabel.text = String(format: LocalizableStrings.PostDetail.User.phone, user.phone)
        userWebsiteLabel.text = String(format: LocalizableStrings.PostDetail.User.website, user.website)
    }
    
    func displayPostCommentsData(postComments: [PostDetailModel.Comment]) {
        self.postCommentsDataSource = postComments
        self.commentsTableView.reloadData()
    }
}
