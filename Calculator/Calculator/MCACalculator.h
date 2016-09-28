//
//  MCACalculator.h
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright (c) 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCAOperator.h"

@interface MCACalculator : NSObject

@property (nonatomic, readonly, getter=isExpressionComplete) BOOL expressionComplete;

- (NSDecimalNumber *)pushOperator:(MCAOperator *)operator withOperand:(NSDecimalNumber *)operand;
- (NSDecimalNumber *)pushOperand:(NSDecimalNumber *)operand;
- (void)pushOperator:(MCAOperator *)operator;

- (NSDecimalNumber *)evaluateExpressionFromHistory;

- (void)clearAllCalculatorHistory;
- (NSString *)getSquareRoot: (NSString *)radicand;
- (NSDecimalNumber *)calculateExponentBase:(NSDecimalNumber *)base raisedToPower:(NSDecimalNumber *)power;
    
@end
