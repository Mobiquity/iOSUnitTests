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

#pragma mark - Test Initialization

- (void)testInitializationWithValidInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@"3.14"];
    XCTAssertNotNil(squarer, @"MCASquarer should be initialized, not nil.");
    XCTAssertNotNil(squarer.operand, @"Operand property should be initialized, not nil.");
}

- (void)testInitializationWithEmptyInput {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@""];
    XCTAssertNil(squarer, @"MCASquarer should be not be initialized");
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

#pragma mark - Test Operation

- (void)testSimpleSquare {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@"2"];
    XCTAssertEqualObjects([squarer squared], [NSDecimalNumber numberWithInt:4]);
}

- (void)testSimpleSquareFormattedString {
    MCASquarer *squarer = [[MCASquarer alloc] initWithString:@"2"];
    XCTAssertEqualObjects([squarer formattedSquaredString], @"Be squared: 4");
}

@end
