//
//  ThoughtWorkWebChatTests.m
//  ThoughtWorkWebChatTests
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserModelManager.h"

@interface ThoughtWorkWebChatTests : XCTestCase

@end

@implementation ThoughtWorkWebChatTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
-(void)testFunc{
    NSLog(@"%@",[UserModelManager sharedInstance].currentUser);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
