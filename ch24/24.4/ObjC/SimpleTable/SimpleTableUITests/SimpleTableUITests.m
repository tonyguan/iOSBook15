//
//  SimpleTableUITests.m
//  SimpleTableUITests
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


#import <XCTest/XCTest.h>

@interface SimpleTableUITests : XCTestCase

@end

@implementation SimpleTableUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    id app =[[XCUIApplication alloc] init];
    
    [app launch];
    
    
    NSLog(@"========================");
    NSLog(@"%@", [app debugDescription]);
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
