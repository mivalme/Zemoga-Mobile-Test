//
//  PostsListViewController+UITableView.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource  {
    func setUpTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: PostTableViewCell.viewID, bundle: .main), forCellReuseIdentifier: PostTableViewCell.viewID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsListDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.viewID, for: indexPath)
        if let cell = cell as? PostTableViewCell, let model = postsListDataSource?[indexPath.row] {
            cell.setUpCell(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postCellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let postId = postsListDataSource?[indexPath.row].id {
            presenter?.deletePost(postId: postId)
            postsListDataSource?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPost = postsListDataSource?[indexPath.row] else { return }
        self.presenter?.didSelectPost(selectedPost: selectedPost)
    }
}
