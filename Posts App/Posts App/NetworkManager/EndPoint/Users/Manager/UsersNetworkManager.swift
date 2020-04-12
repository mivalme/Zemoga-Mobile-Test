//
//  UsersNetworkManager.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

protocol UsersNetworkManagerProtocol {
    func getUser(request: GetUserUseCase.Request, completion: @escaping (PostsAppResult<GetUserUseCase.Response>) -> Void)
}

class UsersNetworkManager: DefaultNetworkManager, UsersNetworkManagerProtocol {
    private let router = Router<UsersAPI>()
    
    func getUser(request: GetUserUseCase.Request, completion: @escaping (PostsAppResult<GetUserUseCase.Response>) -> Void) {
        router.request(.getUser(request: request)) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                completion(.failure(DefaultErrorType.serverFail))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetwork(response)
                
                switch result {
                case .success:
                    do {
                        let response: GetUserUseCase.Response = try self.load(data: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
