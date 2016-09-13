//
//  MCAWolframAlphaQueryTests.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/3/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCABaseTestCase.h"
#import "MCAWolframAlphaQuery.h"

@interface MCAWolframAlphaQueryTests : MCABaseTestCase

@end

@implementation MCAWolframAlphaQueryTests

- (void)testShortQueryString {
    NSString *queryString = @"pi";
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:queryString];
    XCTAssertNotNil(query.queryURL);
}

- (void)testURLEncodingWithQueryString {
    NSString *queryString = @"4 / 5 + ... 3>7";
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:queryString];
    XCTAssertNotNil(query.queryURL);
}

- (void)testURLEncoding {
    NSString *eulerQuery = @"euler's law";
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:eulerQuery];
    XCTAssertNotNil(query.queryURL);
}

- (void)testNilInput {
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:nil];
    XCTAssertNil(query.queryURL);
}
@end
