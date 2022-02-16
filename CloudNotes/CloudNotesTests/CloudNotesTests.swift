//
//  CloudNotesTests - CloudNotesTests.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import XCTest
@testable import CloudNotes

class CloudNotesTests: XCTestCase {
    
    var dataController: CloudNotesDataController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataController = CloudNotesDataController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataController = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        dataController.create(entity: "Note") { managedObject in
            managedObject.setValue(UUID(), forKey: "id")
            managedObject.setValue("Hello", forKey: "title")
            managedObject.setValue("Word", forKey: "body")
            managedObject.setValue(Date(), forKey: "lastModified")
        }
        
        let note = Note.fetchRequest()
        let result = dataController.fetch(request: note)
        print(result)
        XCTAssertTrue(true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
