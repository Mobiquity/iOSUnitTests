//
//  CalculatorUITests.m
//  CalculatorUITests
//
//  Created by Bilal Lolo on 10/10/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CalculatorUITests : XCTestCase

@end

@implementation CalculatorUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"4"] tap];
    
    XCUIElement *button = app.buttons[@"5"];
    [button tap];
    
    XCUIElement *cosButton = app.buttons[@"cos"];
    [cosButton tap];
    
    XCUIElement *acButton = app.buttons[@"AC"];
    [acButton tap];
    [cosButton tap];
    [acButton tap];
    
    XCUIElement *button2 = app.buttons[@"1"];
    [button2 tap];
    [button tap];
    
    XCUIElement *button3 = app.buttons[@"0"];
    [button3 tap];
    [cosButton tap];
    [acButton tap];
    [app.buttons[@"2"] tap];
    [button2 tap];
    [button3 tap];
    [cosButton tap];
    
}

@end
