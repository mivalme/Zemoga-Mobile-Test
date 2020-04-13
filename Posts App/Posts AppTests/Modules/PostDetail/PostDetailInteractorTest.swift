//
//  PostDetailInteractorTest.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import XCTest
@testable import Posts_App

class PostDetailInteractorTest: XCTestCase {
    
    var sut: PostDetailInteractor!
    var mockPresenter: MockPresenter!
    var mockUsersNetworkManager: MockUsersNetworkManager!
    var mockPostsNetworkManager: MockPostsNetworkManager!
    var mockCoreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockUsersNetworkManager = MockUsersNetworkManager()
        mockPostsNetworkManager = MockPostsNetworkManager()
        mockCoreDataManager = MockCoreDataManager()
        sut = PostDetailInteractor(usersNetworkManager: mockUsersNetworkManager, postsNetworkManager: mockPostsNetworkManager, coreDataManager: mockCoreDataManager)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        mockUsersNetworkManager = nil
        mockPostsNetworkManager = nil
        mockCoreDataManager = nil
        sut = nil
    }
    
    func test_fetchUser_success() {
        //Given
        mockPresenter.fetchedUserSuccessCalled = false
        sut.usersNetworkManager = MockUsersNetworkManager(mockResponse: .success)
        
        //When
        sut.fetchUser(userId: 0)
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedUserSuccessCalled)
    }
    
    func test_fetchUser_failure() {
        //Given
        mockPresenter.fetchedUserFailureCalled = false
        sut.usersNetworkManager = MockUsersNetworkManager(mockResponse: .failure)
        
        //When
        sut.fetchUser(userId: 0)
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedUserFailureCalled)
    }
    
    func test_fetchPostComments_success() {
        //Given
        mockPresenter.fetchedPostCommentsSuccessCalled = false
        sut.postsNetworkManager = MockPostsNetworkManager(mockResponse: .success)
        
        //When
        sut.fetchPostComments(postId: 0)
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedPostCommentsSuccessCalled)
    }
    
    func test_fetchPostComments_failure() {
        //Given
        mockPresenter.fetchedPostCommentsFailureCalled = false
        sut.postsNetworkManager = MockPostsNetworkManager(mockResponse: .failure)
        
        //When
        sut.fetchPostComments(postId: 0)
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedPostCommentsFailureCalled)
    }
    
    func test_updatePost_failure() {
        //Given
        mockPresenter.updatePostCoreDataFailureCalled = false
        sut.coreDataManager = MockCoreDataManager(mockResult: .failure)
        
        //When
        sut.updatePost(post: DummyModel.post)
        
        //Then
        XCTAssertTrue(mockPresenter.updatePostCoreDataFailureCalled)
    }
    
    //MARK: - DummyModel
    struct DummyModel {
        static let post = PostDetailModel.Post(userId: 0, id: 0, title: "testTitle", body: "testBody", read: false, favorite: false)
    }
    
    //MARK: - MockPresenter
    class MockPresenter: PostDetailInteractorOutputProtocol {
        var fetchedUserSuccessCalled = false
        var fetchedPostCommentsSuccessCalled = false
        var fetchedPostCommentsFailureCalled = false
        var fetchedUserFailureCalled = false
        var updatePostCoreDataFailureCalled = false
        
        func fetchedUserSuccess(userModel: PostDetailModel.User) {
            fetchedUserSuccessCalled = true
        }
        
        func fetchedUserFailure(errorMessage: String) {
            fetchedUserFailureCalled = true
        }
        
        func fetchedPostCommentsSuccess(commentsModel: [PostDetailModel.Comment]) {
            fetchedPostCommentsSuccessCalled = true
        }
        
        func fetchedPostCommentsFailure(errorMessage: String) {
            fetchedPostCommentsFailureCalled = true
        }
        
        func updatePostCoreDataFailure(errorMessage: String) {
            updatePostCoreDataFailureCalled = true
        }
    }
}
