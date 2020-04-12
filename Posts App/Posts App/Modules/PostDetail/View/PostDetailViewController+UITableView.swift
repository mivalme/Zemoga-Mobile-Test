//
//  PostDetailViewController+UITableView.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func setUpTableView() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.allowsSelection = false
        commentsTableView.register(UINib(nibName: PostCommentTableViewCell.viewID, bundle: .main), forCellReuseIdentifier: PostCommentTableViewCell.viewID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCommentsDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTableViewCell.viewID, for: indexPath)
        if let cell = cell as? PostCommentTableViewCell, let commentBody = postCommentsDataSource?[indexPath.row].body {
            cell.setUpCell(commentBody: commentBody)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postCommentCellHeight
    }
}
