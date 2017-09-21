//
//  NamicsTests.swift
//  NamicsTests
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import XCTest
@testable import Namics

let DEFAULT_TIMEOUT = 5.0

class NamicsTests: XCTestCase {
    
    // MARK: - Properties
    let api = RESTManager.shared
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testApi() {
        let currentExpectation = expectation(description: "Rates fetched successfully")
        
        api.loadData(from: Urls.rates, method: .get, parameters: nil) { (status, response) in
            XCTAssert(response != nil, "Response is nil")
            
            currentExpectation.fulfill()
        }
        
        waitForExpectations(timeout: DEFAULT_TIMEOUT, handler: { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        })
    }
    
}
