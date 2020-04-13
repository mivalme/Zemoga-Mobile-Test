//
//  CoreDataModel.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

struct CoreDataModel {
    struct Post {
        var userId: Int
        var id: Int
        var title: String
        var body: String
    }
}
