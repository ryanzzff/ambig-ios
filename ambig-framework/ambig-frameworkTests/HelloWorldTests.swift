//
//  HelloWorldTests.swift
//  ambig-frameworkTests
//
//  Created by Ryan Lee on 26/6/2021.
//

import XCTest
import ambig_framework

class HelloWorldTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHelloWorld() throws {
        XCTAssertEqual("Hello World", HelloWorld.hello())
    }

}
