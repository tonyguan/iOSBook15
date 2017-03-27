//
//  MyNotesTests.swift
//  MyNotesTests
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import XCTest

class MyNotesTests: XCTestCase, NotesURLConnectionDelegate {

    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFindAll() {

        self.expectation = self.expectation(description: "Request NotesURL")

        let conn = NotesURLConnection()
        conn.delegate = self
        //开始查询
        conn.findAll()
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    // MARK: --查询所有数据方法 成功
    func findAllFinished(_ res: NSDictionary) {

        self.expectation.fulfill()
        XCTAssert(true, "查询所有数据方法 成功")

        let resultCode: NSNumber = res.object(forKey: "ResultCode") as! NSNumber
        XCTAssertEqual(resultCode.intValue, 0)

        let objects = res.object(forKey: "Record") as! NSArray
        XCTAssertEqual(objects.count, 4)

    }

    //MARK: --查询所有数据方法 失败
    func findAllFailed(_ error: NSError) {
        self.expectation.fulfill()
        XCTAssertNotNil(error)
        XCTFail("查询所有数据方法失败")
    }
}
