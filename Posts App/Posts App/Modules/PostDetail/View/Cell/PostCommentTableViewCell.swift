//
//  PostCommentTableViewCell.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(commentBody: String) {
        bodyLabel.text = commentBody
    }
}
