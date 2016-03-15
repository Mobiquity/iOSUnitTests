//
//  MCAHTTPStubUtils.m
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAHTTPStubUtils.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

@implementation MCAHTTPStubUtils

+ (OHHTTPStubsResponse*)responseStubWithStatusOkJsonResponse
{
    NSData* stubData = [@"{\"status\":\"ok\"}" dataUsingEncoding:NSUTF8StringEncoding];
    return [OHHTTPStubsResponse responseWithData:stubData statusCode:200 headers:@{@"Content-Type" : @"text/json"}];
}

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithStatusOkJsonResponse
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES; // Stub ALL requests without any condition
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        return [MCAHTTPStubUtils responseStubWithStatusOkJsonResponse];
    }];
}

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWith500
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES; // Stub ALL requests without any condition
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
       
        return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:500 headers:nil];
    }];
}


+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithJsonFileContents:(NSString*)fileName
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *path = OHPathForFileInBundle(fileName, [NSBundle bundleForClass:self]);
        return [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithData:(NSData *)data
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

@end
