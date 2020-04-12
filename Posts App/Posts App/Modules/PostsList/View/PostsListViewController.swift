//
//  PostsListViewController.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

class PostsListViewController: BaseViewController {
    var presenter: PostsListPresenterProtocol?
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var postsTableView: UITableView!
    
    var postsListDataSource: [PostsListModel.Post]?
    let postCellHeight: CGFloat = 70

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = LocalizableStrings.PostList.title
        setupCustomSegmentedControl()
        setUpTableView()
    }
    
    private func setupCustomSegmentedControl() {
        if #available(iOS 13.0, *) {
            self.segmentedControl.selectedSegmentTintColor = ZemogaThemeColors.CustomGreen
        } else {
            self.segmentedControl.tintColor = ZemogaThemeColors.CustomGreen
        }
        self.segmentedControl.backgroundColor = ZemogaThemeColors.BackgroundColor
        self.segmentedControl.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        self.segmentedControl.setTitleTextAttributes([.foregroundColor : ZemogaThemeColors.CustomGreen ?? UIColor.black], for: .normal)
    }
}

extension PostsListViewController: PostsListViewProtocol {
    func displayPostsList(mdoel: [PostsListModel.Post]) {
        self.postsListDataSource = mdoel
        self.postsTableView.reloadData()
    }
}
