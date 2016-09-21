//
//  MCAHTTPStubUtils.h
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OHHTTPStubsDescriptor;
@class OHHTTPStubsResponse;

@interface MCAHTTPStubUtils : NSObject

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithStatusOkJsonResponse;

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWith500;

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithJsonFileContents:(NSString*)fileName;

+ (id<OHHTTPStubsDescriptor>)interceptAllRequestsAndRespondWithData:(NSData *)data;

+ (OHHTTPStubsResponse*)responseStubWithStatusOkJsonResponse;

@end
