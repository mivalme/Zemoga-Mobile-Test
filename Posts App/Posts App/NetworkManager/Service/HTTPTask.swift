//
//  HTTPTask.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum HTTPTask {
    case request
    case requestWithParameters(parameters: Parameters?)
}
