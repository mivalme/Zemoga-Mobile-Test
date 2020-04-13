//
//  PostTableViewCell.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicatorImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        indicatorImageView.image = nil
    }
    
    func setUpCell(model: PostsListModel.Post) {
        titleLabel.text = model.title
        if model.favorite {
            indicatorImageView.image = ZemogaThemeImages.favoriteIcon
        } else  if !model.read {
            indicatorImageView.image = ZemogaThemeImages.unreadIcon
        } else {
            indicatorImageView.image = nil
        }
    }
    
}
