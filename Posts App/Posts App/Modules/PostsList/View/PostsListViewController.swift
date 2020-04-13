//
//  PostsListViewController.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit
import Lottie

class PostsListViewController: BaseViewController {
    var presenter: PostsListPresenterProtocol?
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var blurView: UIView!
    
    var completePostsList: [PostsListModel.Post]?
    var postsListDataSource: [PostsListModel.Post]?
    let postCellHeight: CGFloat = 70
    let segmentedIndexFavorite = 1
    
    lazy var deleteAnimationView: AnimationView = {
        let view = AnimationView(name: "delete")
        view.frame = self.view.frame
        view.isHidden = true
        self.view.addSubview(view)
        return view
    }()
    
    lazy var loadingAnimationView: AnimationView = {
        let view = AnimationView(name: "loading")
        view.frame = self.view.frame
        view.isHidden = true
        self.view.addSubview(view)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setupUI() {
        self.title = LocalizableStrings.PostList.title
        setupCustomSegmentedControl()
        addReloadButton()
        setUpTableView()
    }
    
    private func setupCustomSegmentedControl() {
        if #available(iOS 13.0, *) {
            self.segmentedControl.selectedSegmentTintColor = ZemogaThemeColors.customGreen
        } else {
            self.segmentedControl.tintColor = ZemogaThemeColors.customGreen
        }
        self.segmentedControl.backgroundColor = ZemogaThemeColors.backgroundColor
        self.segmentedControl.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        self.segmentedControl.setTitleTextAttributes([.foregroundColor : ZemogaThemeColors.customGreen ?? UIColor.black], for: .normal)
    }
    
    private func addReloadButton() {
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonAction))
        navigationItem.rightBarButtonItem =  refreshBarButton
    }
    
    @objc private func reloadButtonAction() {
        postsListDataSource?.removeAll()
        blurView.isHidden = false
        loadingAnimationView.isHidden = false
        loadingAnimationView.play { [weak self] (finished) in
            if finished {
                self?.loadingAnimationView.stop()
                self?.loadingAnimationView.isHidden = true
                self?.blurView.isHidden = true
            }
        }
        self.presenter?.reloadButtonTapped()
    }
    
    @IBAction private func deleteAllButtonAction(_ sender: Any) {
        deleteAnimationView.isHidden = false
        blurView.isHidden = false
        deleteAnimationView.play { [weak self] (finished) in
            if finished {
                self?.deleteAnimationView.stop()
                self?.deleteAnimationView.isHidden = true
                self?.blurView.isHidden = true
            }
        }
        presenter?.deleteAllButtonTapped()
        postsListDataSource?.removeAll()
        completePostsList?.removeAll()
        postsTableView.reloadData()
    }
    
    @IBAction func segmentedControlChange(_ sender: Any) {
        guard let completePostsList = self.completePostsList else { return }
        displayPostsList(model: completePostsList)
    }
}

extension PostsListViewController: PostsListViewProtocol {
    func displayPostsList(model: [PostsListModel.Post]) {
        self.completePostsList = model
        if segmentedControl.selectedSegmentIndex == segmentedIndexFavorite {
            self.postsListDataSource = model.filter({ $0.favorite == true })
        } else {
            self.postsListDataSource = model
        }
        self.postsTableView.reloadData()
    }
}
