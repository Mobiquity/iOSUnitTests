//
//  MCAOperatorTests.m
//  Calculator
//
//  Created by Brendan Carey on 3/15/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"
#import "MCAOperator.h"

@interface MCAOperatorTests : MCABaseTestCase

@end

@implementation MCAOperatorTests

- (void)testMCAOperator_operate_invokesOperationBlock
{
    // Arrange
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expected operations block to be invoked."];
    MCAOperator *operator = [[MCAOperator alloc] initWithPrecedence:0 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        [expectation fulfill];
        return [NSDecimalNumber maximumDecimalNumber];
    }];
    
    // Act
    [operator operateOnOperand1:[NSDecimalNumber minimumDecimalNumber] operand2:[NSDecimalNumber minimumDecimalNumber]];
    
    //Assert
    [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

@end
