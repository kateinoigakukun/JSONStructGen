//
//  JSONStructGenTest.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/26.
//
//

import XCTest
import SwiftyJSON
@testable import JSONStructGen

class JSONStructGenTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func jsonProvider() -> JSON {
        return JSON(dictionaryLiteral: [
            ("key1", 1),
            ("key2", "string"),
            ("key3", [1,2,3]),
            ("key4", ["sub_key1": 1])
            ])
    }

    func testJsonParse() {

        let structGen = StructParser(structName: "Test", json: jsonProvider())


        let property = structGen.properties

        let keys = property.map { $0.key }
        XCTAssertEqual(Set(keys), ["key1", "key2", "key3", "key4"])

        print(property)
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
