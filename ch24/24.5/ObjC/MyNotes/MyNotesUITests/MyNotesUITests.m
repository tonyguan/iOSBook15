//
//  MyNotesUITests.m
//  MyNotesUITests
//
//  Created by tony on 2017/3/8.
//  Copyright © 2017年 tony. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MyNotesUITests : XCTestCase

@end

@implementation MyNotesUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
    
}

- (void)tearDown {
    [super tearDown];
}

#pragma --查询操作
- (void)testMasterViewControllerTableViewCellFindAll {
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    //获得当前界面中的表视图
    XCUIElement* tableView = [app.tables elementBoundByIndex:0];
    //断言表视图存在
    XCTAssertTrue(tableView.exists);
    //断言表视图单元格数为0
    XCTAssertEqual(tableView.cells.count, 2);
    
    XCUIElement* cell1 = [tableView.cells elementBoundByIndex:0];
    XCTAssertTrue(cell1.staticTexts[@"Welcome to MyNote."].exists);
    
    XCUIElement* cell2 = [tableView.cells elementBoundByIndex:1];
    XCTAssertTrue(cell2.staticTexts[@"欢迎使用MyNote。"].exists);
    
}

#pragma --增加备忘录操作
- (void)testAddViewControllerSave {
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    //获得当前界面中的表视图
    XCUIElement* tableView =  [app.tables elementBoundByIndex:0];
    NSUInteger cellsCount = tableView.cells.count;
    
    //点击添加“增加”按钮，跳转到增加界面
    [app.navigationBars[@"备忘录"].buttons[@"Add"] tap];
    
    //获得增加界面中TextView对象
    XCUIElement* textView = app.textViews[@"Text View"];
    [textView tap];
    [textView typeText:@"HelloWorld"];
    
    //在增加界面添加Save按钮，跳转到备忘录界面
    [app.navigationBars[@"增加"].buttons[@"Save"] tap];
    //断言备忘录界面中表视图单元格数为+1
    XCTAssertEqual(tableView.cells.count, cellsCount + 1);
    
}

#pragma --增加备忘录时取消操作
- (void)testAddViewControllerCancel {
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    //获得当前界面中的表视图
    XCUIElement* tableView =  [app.tables elementBoundByIndex:0];
    NSUInteger cellsCount = tableView.cells.count;
    
    //点击添加“增加”按钮，跳转到增加界面
    [app.navigationBars[@"备忘录"].buttons[@"Add"] tap];
    
    //在增加界面添加Save按钮，跳转到备忘录界面
    [app.navigationBars[@"增加"].buttons[@"Cancel"] tap];
    //断言备忘录界面中表视图单元格数没有+1
    XCTAssertEqual(tableView.cells.count, cellsCount);
    
}

#pragma --删除最后一个单元格操作
- (void)testMasterViewControllerTableViewCellRemove {
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    XCUIElement* navigationBar = app.navigationBars[@"备忘录"];
    [navigationBar.buttons[@"Edit"] tap];
    
    XCUIElement* tableView =  [app.tables elementBoundByIndex:0];
    NSUInteger cellsCount = tableView.cells.count;
    
    [[tableView.buttons elementBoundByIndex:0] tap];
    [tableView.buttons[@"Delete"] tap];
    [navigationBar.buttons[@"Done"] tap];
    
    XCTAssertEqual(tableView.cells.count, cellsCount - 1);
    
    XCUIElement* staticTexts = tableView.cells.staticTexts[@"Welcome to MyNote."];
    XCTAssertTrue(!staticTexts.exists);
    
}

#pragma --详细界面中显示操作
- (void)testDetailViewControllerShowDetail {
    
    XCUIApplication* app = [[XCUIApplication alloc] init];
    //获得当前界面中的表视图
    XCUIElement* tableView =  [app.tables elementBoundByIndex:0];
    
    XCUIElement* cell1 = [tableView.cells elementBoundByIndex:0];
    [cell1 tap];
    
    XCUIElement* welcomeStaticText = app.staticTexts[@"Welcome to MyNote."];
    //断言
    XCTAssertTrue(welcomeStaticText.exists);
    
    [app.navigationBars[@"详细"].buttons[@"备忘录"] tap];
}

@end
