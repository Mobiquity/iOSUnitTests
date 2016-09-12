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

- (void)testWolframURLEscaping {
    NSString *queryString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-_.~!#$&'()*+,/:;=?@[]";
    NSString *expected = @"http://api.wolframalpha.com/v2/query?input=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-_.~!%23%24%26'()*%2B%2C%2F%3A%3B%3D%3F%40%5B%5D&appid=7455XJ-6VH386Y4Y4&format=plaintext";
    
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:queryString];
    NSString *result = [query.queryURL absoluteString];
    
    XCTAssertTrue([expected isEqualToString:result]);
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
