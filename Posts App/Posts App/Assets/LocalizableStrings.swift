//
//  Strings.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 9/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

extension String {
    fileprivate var localizable: String {
        return NSLocalizedString(self, comment: "POSTS APP TEXT")
    }
}

struct LocalizableStrings {
    struct PostList {
        static var title: String { return "PostList.title".localizable }
    }
    
    struct PostDetail {
        static var title: String { return "PostDetail.title".localizable }
        
        struct User {
            static var name: String { return "PostDetail.User.name".localizable }
            static var email: String { return "PostDetail.User.email".localizable }
            static var phone: String { return "PostDetail.User.phone".localizable }
            static var website: String { return "PostDetail.User.website".localizable }
        }
    }
}
