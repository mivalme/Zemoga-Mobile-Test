//
//  MockUsersNetworkManager.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation
@testable import Posts_App

class MockUsersNetworkManager: UsersNetworkManagerProtocol {
    var mockResponse: MockNetworkManagerResponse?
    
    init(mockResponse: MockNetworkManagerResponse? = nil) {
        self.mockResponse = mockResponse
    }
    
    func getUser(request: GetUserUseCase.Request, completion: @escaping (PostsAppResult<GetUserUseCase.Response>) -> Void) {
        guard let mockResponse = self.mockResponse else { return }
        switch mockResponse {
        case .success:
            completion(.success(DummyModel.GetUserUseCaseResponse))
        case .failure:
            completion(.failure(DummyModel.error))
        }
    }
    
    //MARK: - DummyModel
    struct DummyModel {
        static let GetUserUseCaseResponse: GetUserUseCase.Response = [GetUserUseCase.User(name: "testName", email: "testEmail", phone: "testPhone", website: "testwebsite")]
        static let error = MockNetworkManagerError(localizedDescription: "mockNetworkManagerError")
    }
}
