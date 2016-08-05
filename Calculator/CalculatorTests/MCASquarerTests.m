//
//  MCASquarerTests.m
//  Calculator
//
//  Created by Chris Nielubowicz on 8/4/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"
#import "MCASquarer.h"

@interface MCASquarerTests : MCABaseTestCase

@end

@implementation MCASquarerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialization {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@""];
    XCTAssertNotNil(squarer, @"MCASquarer should be initialized, not nil.");
}

- (void)testInitializationWithValidInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@"3.14"];
    XCTAssertNotNil(squarer, @"MCASquarer should be initialized, not nil.");
    XCTAssertNotNil(squarer.operand, @"Operand property should be initialized, not nil.");
}

- (void)testInitializationWithInvalidInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@"abcdefg.hijk"];
    XCTAssertNil(squarer, @"MCASquarer should be not initialized");
}

- (void)testInitializationWithNilInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:nil];
    XCTAssertNil(squarer, @"MCASquarer should be not initialized");
}

- (void)testInitializationWithGarbageInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:((NSString *)@{@"dictionary" : @"value"})];
    XCTAssertNil(squarer, @"MCASquarer should be not initialized");
}

@end
