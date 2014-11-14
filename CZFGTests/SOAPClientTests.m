//
//  SOAPClientTests.m
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SOAPClientTests : XCTestCase

@end

@implementation SOAPClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    
    SOAPClient *client = [[SOAPClient alloc] initWithMethod:@"TB_Volume_GetList"
                                                      xmlns:@"http://tempuri.org/"
                                                     params:@{@"Key":@"yfr6D+qBPjjliRmZj5ZRd0oH9vmW1FWd"}
                                                 requestUrl:@"http://222.85.133.20:8088/LawsInterface.asmx" completedBlock:^(id result) {
                                                     
                                                 } errorBlock:^(NSError *error) {
                                                     NSLog(@"出错");
                                                 }];
    [client startAsyncRequest];
  
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
