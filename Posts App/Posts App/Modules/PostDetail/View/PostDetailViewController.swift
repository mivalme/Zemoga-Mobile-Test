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
    let favoriteButton = UIButton()
    private var favoriteState: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setUpTableView()
        addFavoriteButton()
        self.title = LocalizableStrings.PostDetail.title
    }
    
    private func addFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.setImage(ZemogaThemeImages.favoriteIcon?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.tintColor = favoriteState ?? false ? ZemogaThemeColors.favoriteYellow : UIColor.white
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    @objc private func favoriteButtonAction() {
        favoriteState?.toggle()
        guard let favoriteState = self.favoriteState else { return }
        favoriteButton.tintColor = favoriteState ? ZemogaThemeColors.favoriteYellow : UIColor.white
        presenter?.favoriteButtonTapped(favoriteState: favoriteState)
    }

}

extension PostDetailViewController: PostDetailViewProtocol {
    func displayPostData(post: PostDetailModel.Post) {
        bodyLabel.text = post.body
        favoriteState = post.favorite
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
    
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: LocalizableStrings.PostDetail.errorAlertTitle, message: errorMessage, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: LocalizableStrings.PostDetail.errorAlertButtonTitle, style: .default, handler: nil)
        alert.addAction(continueAction)
        self.present(alert, animated: true, completion: nil)
    }
}
