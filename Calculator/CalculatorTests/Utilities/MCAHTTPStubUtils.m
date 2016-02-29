//
//  MCAHTTPStubUtils.m
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAHTTPStubUtils.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

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
        
        return [HttpStubUtils responseStubWithStatusOkJsonResponse];
    }];
}

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWith500
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES; // Stub ALL requests without any condition
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        return [OHHTTPStubsResponse responseWithData:nil statusCode:500 headers:nil];
    }];
}


+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithJsonFileContents:(NSString*)fileName
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "wsresponse.json" stub file
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(fileName,nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
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
