//
//  PostsListPresenterTest.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import XCTest
@testable import Posts_App

class PostsListPresenterTest: XCTestCase {
    
    var sut: PostsListPresenter!
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = PostsListPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }
    
    func test_viewDidLoad() {
        //Given
        mockInteractor.fetchSavedPostsListCalled = false
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(mockInteractor.fetchSavedPostsListCalled)
    }
    
    func test_viewWillAppear() {
        //Given
        mockInteractor.fetchSavedPostsListCalled = false
        
        //When
        sut.viewWillAppear()
        
        //Then
        XCTAssertTrue(mockInteractor.fetchSavedPostsListCalled)
    }
    
    func test_didSelectPost() {
        //Given
        mockRouter.goToPostDetailCalled = false
        
        //When
        sut.didSelectPost(selectedPost: DummyModel.post)
        
        //Then
        XCTAssertTrue(mockRouter.goToPostDetailCalled)
    }
    
    func test_deleteAllButtonTapped() {
        //Given
        mockInteractor.deleteAllPostsCoreDataCalled = false
        
        //When
        sut.deleteAllButtonTapped()
        
        //Then
        XCTAssertTrue(mockInteractor.deleteAllPostsCoreDataCalled)
    }
    
    func test_deletePost() {
        //Given
        mockInteractor.deletePostCoreDataCalled = false
        
        //When
        sut.deletePost(postId: 0)
        
        //Then
        XCTAssertTrue(mockInteractor.deletePostCoreDataCalled)
    }
    
    func test_reloadButtonTapped() {
        //Given
        mockInteractor.fetchPostsCalled = false
        
        //When
        sut.reloadButtonTapped()
        
        //Then
        XCTAssertTrue(mockInteractor.fetchPostsCalled)
    }
    
    func test_fetchedPostsSuccess() {
        //Given
        mockView.displayPostsListCalled = false
        
        //When
        sut.fetchedPostsSuccess(model: [DummyModel.post])
        
        //Then
        XCTAssertTrue(mockView.displayPostsListCalled)
    }
    
    func test_fetchedPostsFailure() {
        //Given
        mockView.showErrorAlertCalled = false
        
        //When
        sut.fetchedPostsFailure(errorMessage: String())
        
        //Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
    }
        
    
    //MARK: - DummyModel
    struct DummyModel {
        static let post = PostsListModel.Post (userId: 0, id: 0, title: "testTitle", body: "testBody", read: false, favorite: false)
    }
    
    //MARK: - MockView
    class MockView: PostsListViewProtocol {
        var displayPostsListCalled = false
        var showErrorAlertCalled = false
        
        func displayPostsList(model: [PostsListModel.Post]) {
            displayPostsListCalled = true
        }
        
        func showErrorAlert(errorMessage: String) {
            showErrorAlertCalled = true
        }
    }
    
    //MARK: - MockRouter
    class MockRouter: PostsListRouterProtocol {
        var goToPostDetailCalled = false
        
        func goToPostDetail(selectedPost: PostDetailModel.Post) {
            goToPostDetailCalled = true
        }
    }
    
    //MARK: - MockInteractor
    class MockInteractor: PostsListInteractorProtocol {
        var fetchSavedPostsListCalled = false
        var deleteAllPostsCoreDataCalled = false
        var deletePostCoreDataCalled = false
        var fetchPostsCalled = false
        
        func fetchPosts() {
            fetchPostsCalled = true
        }
        
        func fetchSavedPostsList() {
            fetchSavedPostsListCalled = true
        }
        
        func deleteAllPostsCoreData() {
            deleteAllPostsCoreDataCalled = true
        }
        
        func deletePostCoreData(postId: Int) {
            deletePostCoreDataCalled = true
        }
    }
}
