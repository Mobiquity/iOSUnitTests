//
//  MCAWolframAlphaOutputParserTests.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/13/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCABaseTestCase.h"
#import "MCAWolframAlphaOutputParser.h"

@interface MCAWolframAlphaOutputParserTests : MCABaseTestCase

@end

@implementation MCAWolframAlphaOutputParserTests

static NSString * const DidYouMeanXMLData = @"euler";
static NSString * const CleanPlaintextXMLData = @"pi";
static NSString * const ArithmeticXMLData = @"arithmetic";

static CGFloat const MCAXMLTestTimeout = 5.0;

- (NSData *)dataFromFile:(NSString *)filename {
    NSURL *filePath = [[NSBundle bundleForClass:[self class]] URLForResource:filename withExtension:@"xml"];
    NSData *data = [NSData dataWithContentsOfURL:filePath];
    return data;
}

- (void)testNullData {
    XCTestExpectation *parseExpectation = [self expectationWithDescription:@"Null Data complete"];
    MCAWolframAlphaOutputParser *parser = [[MCAWolframAlphaOutputParser alloc] initWithData:nil];
    [parser parseWithCompletion:^(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error) {
        XCTAssertNil(content, @"No content should be parsed for empty document");
        XCTAssertNotNil(error, @"Error object should not be nil");
        [parseExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:MCAXMLTestTimeout handler:nil];
}

- (void)testHappyData {
    XCTestExpectation *parseExpectation = [self expectationWithDescription:@"Happy Data complete"];
    NSData *xmlData = [self dataFromFile:CleanPlaintextXMLData];
    XCTAssertNotNil(xmlData);
    MCAWolframAlphaOutputParser *parser = [[MCAWolframAlphaOutputParser alloc] initWithData:xmlData];
    [parser parseWithCompletion:^(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error) {
        XCTAssertNotNil(content, @"Content should be parsed for %@", CleanPlaintextXMLData);
        XCTAssertNil(error, @"Error object should be nil");
        // TODO: check contents
        [parseExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:MCAXMLTestTimeout handler:nil];
}

- (void)testUnsupportedData {
    XCTestExpectation *parseExpectation = [self expectationWithDescription:@"Did You Mean? data complete"];
    NSData *xmlData = [self dataFromFile:DidYouMeanXMLData];
    XCTAssertNotNil(xmlData);
    MCAWolframAlphaOutputParser *parser = [[MCAWolframAlphaOutputParser alloc] initWithData:xmlData];
    [parser parseWithCompletion:^(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error) {
        XCTAssertNotNil(content, @"Content should be parsed for %@", CleanPlaintextXMLData);
        XCTAssertNil(error, @"Error object should be nil");
        // TODO: check contents
        [parseExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:MCAXMLTestTimeout handler:nil];
}

- (void)testArithmeticData {
    XCTestExpectation *parseExpectation = [self expectationWithDescription:@"Arithmetic check complete"];
    NSData *xmlData = [self dataFromFile:ArithmeticXMLData];
    XCTAssertNotNil(xmlData);
    MCAWolframAlphaOutputParser *parser = [[MCAWolframAlphaOutputParser alloc] initWithData:xmlData];
    [parser parseWithCompletion:^(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error) {
        XCTAssertNotNil(content, @"Content should be parsed for %@", CleanPlaintextXMLData);
        XCTAssertNil(error, @"Error object should be nil");
        // TODO: check contents
        [parseExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:MCAXMLTestTimeout handler:nil];
}

- (void)testBadData {
    XCTestExpectation *parseExpectation = [self expectationWithDescription:@"Bad Data complete"];
    NSMutableData *xmlData = [[self dataFromFile:CleanPlaintextXMLData] mutableCopy];
    [xmlData resetBytesInRange:NSMakeRange(0, 20)]; // Directly manipulate data to cause parsing errors
    XCTAssertNotNil(xmlData);
    
    MCAWolframAlphaOutputParser *parser = [[MCAWolframAlphaOutputParser alloc] initWithData:xmlData];
    [parser parseWithCompletion:^(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error) {
        XCTAssertNil(content, @"Content (%@) should not be parsed for mangled data", content);
        XCTAssertNotNil(error, @"Error object should not be nil");
        // TODO: check contents
        [parseExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:MCAXMLTestTimeout handler:nil];
}
@end
