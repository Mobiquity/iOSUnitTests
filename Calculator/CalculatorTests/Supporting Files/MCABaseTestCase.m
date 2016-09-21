//
//  MCABaseTestCase.m
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "MCAHTTPStubUtils.h"

NSTimeInterval const TIMEOUT = 5.0;

@interface MCABaseTestCase ()

@end

@implementation MCABaseTestCase

- (void)setUp {
    
    [super setUp];
    [MCAHTTPStubUtils interceptAllRequestsAndRespondWithStatusOkJsonResponse];
    
}

- (void)tearDown {
    
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
    
}

@end
