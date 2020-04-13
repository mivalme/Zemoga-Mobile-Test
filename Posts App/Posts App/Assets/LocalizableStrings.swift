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
    struct PostsList {
        static var title: String { return "PostsList.title".localizable }
        static var errorAlertTitle: String { return "PostsList.errorAlertTitle".localizable }
        static var errorAlertButtonTitle: String { return "PostsList.errorAlertTitle".localizable }
    }
    
    struct PostDetail {
        static var title: String { return "PostDetail.title".localizable }
        
        struct User {
            static var name: String { return "PostDetail.User.name".localizable }
            static var email: String { return "PostDetail.User.email".localizable }
            static var phone: String { return "PostDetail.User.phone".localizable }
            static var website: String { return "PostDetail.User.website".localizable }
        }
        
        static var errorAlertTitle: String { return "PostDetail.errorAlertTitle".localizable }
        static var errorAlertButtonTitle: String { return "PostDetail.errorAlertTitle".localizable }
    }
}
