//
//  PostsListInteractorTest.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import XCTest
@testable import Posts_App

class PostsListInteractorTest: XCTestCase {
    
    var sut: PostsListInteractor!
    var mockPresenter: MockPresenter!
    var mockPostsNetworkManager: MockPostsNetworkManager!
    var mockCoreDataManager: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockPostsNetworkManager = MockPostsNetworkManager()
        mockCoreDataManager = MockCoreDataManager()
        sut = PostsListInteractor(postsNetworkManager: mockPostsNetworkManager, coreDataManager: mockCoreDataManager)
        sut.presenter = mockPresenter
    }

    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        mockPostsNetworkManager = nil
        mockCoreDataManager = nil
        sut = nil
    }
    
    func test_fetchPosts_success() {
        //Given
        mockPresenter.fetchedPostsSuccessCalled = false
        sut.postsNetworkManager = MockPostsNetworkManager(mockResponse: .success)
        
        //When
        sut.fetchPosts()
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedPostsSuccessCalled)
    }
    
    func test_fetchPosts_failure() {
        //Given
        mockPresenter.fetchedPostsFailureCalled = false
        sut.postsNetworkManager = MockPostsNetworkManager(mockResponse: .failure)
        
        //When
        sut.fetchPosts()
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedPostsFailureCalled)
    }
    
    func test_fetchSavedPostsList_success() {
        //Given
        mockPresenter.fetchedPostsSuccessCalled = false
        sut.coreDataManager = MockCoreDataManager(mockResult: .success)
        
        //When
        sut.fetchSavedPostsList()
        
        //Then
        XCTAssertTrue(mockPresenter.fetchedPostsSuccessCalled)
    }
    
    func test_fetchSavedPostsList_failure() {
        //Given
        mockPresenter.coreDataFailureCalled = false
        sut.coreDataManager = MockCoreDataManager(mockResult: .failure)
        
        //When
        sut.fetchSavedPostsList()
        
        //Then
        XCTAssertTrue(mockPresenter.coreDataFailureCalled)
    }
    
    func test_deleteAllPostsCoreData_failure() {
        //Given
        mockPresenter.coreDataFailureCalled = false
        sut.coreDataManager = MockCoreDataManager(mockResult: .failure)
        
        //When
        sut.deleteAllPostsCoreData()
        
        //Then
        XCTAssertTrue(mockPresenter.coreDataFailureCalled)
    }
    
    func test_deletePostCoreData_failure() {
        //Given
        mockPresenter.coreDataFailureCalled = false
        sut.coreDataManager = MockCoreDataManager(mockResult: .failure)
        
        //When
        sut.deletePostCoreData(postId: 0)
        
        //Then
        XCTAssertTrue(mockPresenter.coreDataFailureCalled)
    }
    
    //MARK: - MockPresenter
    class MockPresenter: PostsListInteractorOutputProtocol {
        var fetchedPostsSuccessCalled = false
        var coreDataFailureCalled = false
        var fetchedPostsFailureCalled = false
        
        func fetchedPostsSuccess(model: [PostsListModel.Post]) {
            fetchedPostsSuccessCalled = true
        }
        
        func fetchedPostsFailure(errorMessage: String) {
            fetchedPostsFailureCalled = true
        }
        
        func coreDataFailure(errorMessage: String) {
            coreDataFailureCalled = true
        }
    }

}
