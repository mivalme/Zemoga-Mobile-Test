//
//  EndPointType.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}

extension EndPointType {
    private var environmentBaseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var baseURL: URL {
        return environmentBaseURL
    }
}
