//
//  PostsNetworkManager.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 10/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation

protocol PostsNetworkManagerProtocol {
    func getPosts(completion: @escaping (PostsAppResult<GetPostsUseCase.Response>) -> Void)
    func getPostComments(request: GetPostCommentsUseCase.Request, completion: @escaping (PostsAppResult<GetPostCommentsUseCase.Response>) -> Void)
}

class PostsNetworkManager: DefaultNetworkManager, PostsNetworkManagerProtocol {
    private let router = Router<PostsAPI>()
    
    func getPosts(completion: @escaping (PostsAppResult<GetPostsUseCase.Response>) -> Void) {
        router.request(.getPosts) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                completion(.failure(DefaultErrorType.serverFail))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetwork(response)
                
                switch result {
                case .success:
                    do {
                        let response: GetPostsUseCase.Response = try self.load(data: data)
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
    
    func getPostComments(request: GetPostCommentsUseCase.Request, completion: @escaping (PostsAppResult<GetPostCommentsUseCase.Response>) -> Void) {
        router.request(.getPostComments(request)) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                completion(.failure(DefaultErrorType.serverFail))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetwork(response)
                
                switch result {
                case .success:
                    do {
                        let response: GetPostCommentsUseCase.Response = try self.load(data: data)
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
