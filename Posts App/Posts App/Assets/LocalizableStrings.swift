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
}
