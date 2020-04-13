//
//  MockCoreDataManager.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import Foundation
@testable import Posts_App

enum MockCoreDataResult {
    case success
    case failure
}

struct MockCoreDataError: Error {
    var localizedDescription: String
}

class MockCoreDataManager: CoreDataManagerProtocol {
    var mockResult: MockCoreDataResult?
    
    init(mockResult: MockCoreDataResult) {
        self.mockResult = mockResult
    }
    
    func getPostsList(completion: @escaping (CoreDataResult<[CoreDataModel.Post]>) -> Void) {
        guard let mockResult = self.mockResult else { return }
        switch mockResult {
        case .success:
            completion(.success([DummyModel.post]))
        case .failure:
            completion(.failure(MockCoreDataError(localizedDescription: "mockCoreDataError")))
        }
    }
    
    func savePostsList(postsModel: [CoreDataModel.Post], completion: @escaping (CoreDataResult<String>) -> Void) {
        
    }
    
    func updatePost(postModel: CoreDataModel.Post, completion: @escaping (CoreDataResult<String>) -> Void) {
        
    }
    
    func deleteAllPosts(completion: @escaping (CoreDataResult<String>) -> Void) {
        guard let mockResult = self.mockResult else { return }
        switch mockResult {
        case .success:
            completion(.success(String()))
        case .failure:
            completion(.failure(MockCoreDataError(localizedDescription: "mockCoreDataError")))
        }
    }
    
    func deletePost(postId: Int, completion: @escaping (CoreDataResult<String>) -> Void) {
        guard let mockResult = self.mockResult else { return }
        switch mockResult {
        case .success:
            completion(.success(String()))
        case .failure:
            completion(.failure(MockCoreDataError(localizedDescription: "mockCoreDataError")))
        }
    }
    
    //MARK: - DummyModel
    struct DummyModel {
        static let post = CoreDataModel.Post(userId: 0, id: 0, title: "testTitle", body: "testBody", read: false, favorite: false)
    }
}
