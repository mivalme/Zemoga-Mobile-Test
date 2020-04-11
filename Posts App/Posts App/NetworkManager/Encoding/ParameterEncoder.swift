//
//  ParameterEncoder.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}

typealias Parameters = [String : Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
