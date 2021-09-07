//
//  redditorTests.swift
//  redditorTests
//
//  Created by Miguel Fraire on 9/4/21.
//

import XCTest
@testable import redditor

class redditorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreatingFeedCellViewModels() throws {
        let feedViewModel = FeedViewModel()
        let post = ChildData(title: "title", url: "URL", thumbnail: "thumbnail", thumbnailHeight: 150, thumbnailWidth: 150, score: 10, numComments: 10, isVideo: true)
        
        let feedCellViewModelOne = FeedCellViewModel(title: post.title, thumbnail: post.thumbnail!, score: post.score, numComments: post.numComments)
        let feedCellViewModelTwo = feedViewModel.createCellModel(post: post)
        
        XCTAssertEqual(feedCellViewModelOne, feedCellViewModelTwo)
    }
}
