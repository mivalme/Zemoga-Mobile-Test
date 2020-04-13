//
//  MockNetworkManager.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum MockNetworkManagerResponse {
    case success
    case failure
}

struct MockNetworkManagerError: Error {
    var localizedDescription: String
}
