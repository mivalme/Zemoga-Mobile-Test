//
//  PostDetailPresenterTest.swift
//  Posts AppTests
//
//  Created by Miguel Valcarcel on 13/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import XCTest
@testable import Posts_App

class PostDetailPresenterTest: XCTestCase {
    
    var sut: PostDetailPresenter!
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = PostDetailPresenter()
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
    
    func test_viewDidLoad_selectedPostNotNil() {
        //Given
        mockView.displayPostDataCalled = false
        mockInteractor.fetchUserCalled = false
        mockInteractor.fetchPostCommentsCalled = false
        mockInteractor.updatePostCalled = false
        sut.selectedPost = DummyModel.selectedPost
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(mockView.displayPostDataCalled)
        XCTAssertTrue(mockInteractor.fetchUserCalled)
        XCTAssertTrue(mockInteractor.fetchPostCommentsCalled)
        XCTAssertTrue(mockInteractor.updatePostCalled)
    }
    
    func test_viewDidLoad_selectedPostNil() {
        //Given
        mockView.displayPostDataCalled = false
        mockInteractor.fetchUserCalled = false
        mockInteractor.fetchPostCommentsCalled = false
        mockInteractor.updatePostCalled = false
        sut.selectedPost = nil
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertFalse(mockView.displayPostDataCalled)
        XCTAssertFalse(mockInteractor.fetchUserCalled)
        XCTAssertFalse(mockInteractor.fetchPostCommentsCalled)
        XCTAssertFalse(mockInteractor.updatePostCalled)
    }
    
    func test_favoriteButtonTapped_selectedPostNotNil() {
        //Given
        mockInteractor.updatePostCalled = false
        sut.selectedPost = DummyModel.selectedPost
        
        //When
        sut.favoriteButtonTapped(favoriteState: DummyModel.favoriteState)
        
        //Then
        XCTAssertTrue(mockInteractor.updatePostCalled)
    }
    
    func test_favoriteButtonTapped_selectedPostNil() {
        //Given
        mockInteractor.updatePostCalled = false
        sut.selectedPost = nil
        
        //When
        sut.favoriteButtonTapped(favoriteState: DummyModel.favoriteState)
        
        //Then
        XCTAssertFalse(mockInteractor.updatePostCalled)
    }
    
    func test_fetchedUserSuccess() {
        //Given
        mockView.displayUserDataCalled = false
        
        //When
        sut.fetchedUserSuccess(userModel: DummyModel.user)
        
        //Then
        XCTAssertTrue(mockView.displayUserDataCalled)
    }
    
    func test_fetchedUserFailure() {
        //Given
        mockView.showErrorAlertCalled = false
        
        //When
        sut.fetchedUserFailure(errorMessage: String())
        
        //Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
    }
    
    func test_fetchedPostCommentsSuccess() {
        //Given
        mockView.displayPostCommentsDataCalled = false
        
        //When
        sut.fetchedPostCommentsSuccess(commentsModel: [DummyModel.comment])
        
        //Then
        XCTAssertTrue(mockView.displayPostCommentsDataCalled)
    }
    
    func test_fetchedPostCommentsFailure() {
        //Given
        mockView.showErrorAlertCalled = false
        
        //When
        sut.fetchedPostCommentsFailure(errorMessage: String())
        
        //Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
    }
    
    func test_updatePostCoreDataFailure() {
        //Given
        mockView.showErrorAlertCalled = false
        
        //When
        sut.updatePostCoreDataFailure(errorMessage: String())
        
        //Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
    }
    
    //MARK: - DummyModel
    struct DummyModel {
        static let selectedPost = PostDetailModel.Post(userId: 0, id: 0, title: "testTitle", body: "testBody", read: false, favorite: false)
        static let favoriteState = false
        static let user = PostDetailModel.User(name: "testName", email: "testEmail", phone: "testPhone", website: "testWebsite")
        static let comment = PostDetailModel.Comment(postId: 0, id: 0, name: "testName", email: "testEmail", body: "testBody")
    }
    
    //MARK: - MockView
    class MockView: PostDetailViewProtocol {
        var displayPostDataCalled = false
        var showErrorAlertCalled = false
        var displayPostCommentsDataCalled = false
        var displayUserDataCalled = false
        
        func displayPostData(post: PostDetailModel.Post) {
            displayPostDataCalled = true
        }
        
        func displayUserData(user: PostDetailModel.User) {
            displayUserDataCalled = true
        }
        
        func displayPostCommentsData(postComments: [PostDetailModel.Comment]) {
            displayPostCommentsDataCalled = true
        }
        
        func showErrorAlert(errorMessage: String) {
            showErrorAlertCalled = true
        }
    }
    
    //MARK: - MockRouter
    class MockRouter: PostDetailRouterProtocol {
        
    }
    
    //MARK: - MockInteractor
    class MockInteractor: PostDetailInteractorProtocol {
        var fetchUserCalled = false
        var fetchPostCommentsCalled = false
        var updatePostCalled = false
        
        func fetchUser(userId: Int) {
            fetchUserCalled = true
        }
        
        func fetchPostComments(postId: Int) {
            fetchPostCommentsCalled = true
        }
        
        func updatePost(post: PostDetailModel.Post) {
            updatePostCalled = true
        }
        
        
    }
}
