//
//  MockPostsNetworkManager.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation
@testable import Posts_App

class MockPostsNetworkManager: PostsNetworkManagerProtocol {
    var mockResponse: MockNetworkManagerResponse?
    
    init(mockResponse: MockNetworkManagerResponse? = nil) {
        self.mockResponse = mockResponse
    }
    
    func getPosts(completion: @escaping (PostsAppResult<GetPostsUseCase.Response>) -> Void) {
        guard let mockResponse = self.mockResponse else { return }
        switch mockResponse {
        case .success:
            completion(.success(DummyModel.GetPostsUseCaseResponse))
        case .failure:
            completion(.failure(DummyModel.error))
        }
    }
    
    func getPostComments(request: GetPostCommentsUseCase.Request, completion: @escaping (PostsAppResult<GetPostCommentsUseCase.Response>) -> Void) {
        
    }
    
    struct DummyModel {
        static let GetPostsUseCaseResponse: GetPostsUseCase.Response = [GetPostsUseCase.Post(userId: 0, id: 0, title: "testTitle", body: "testBody")]
        static let error = MockNetworkManagerError(localizedDescription: "mockNetworkManagerError")
    }
}
