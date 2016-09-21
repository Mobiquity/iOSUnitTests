//
//  MCAOperator.m
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright (c) 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAOperator.h"

@interface MCAOperator ()

@property (nonatomic, copy, nonnull) MCABinaryOperationBlock operationBlock;

@end

@implementation MCAOperator

-(instancetype)initWithPrecedence:(NSUInteger)precedence operationBlock:(MCABinaryOperationBlock)operationBlock
{
    if (self = [super init]) {
        _precedence = precedence;
        _operationBlock = operationBlock;
    }
    return self;
}

-(NSDecimalNumber *)operateOnOperand1:(NSDecimalNumber *)operand1 operand2:(NSDecimalNumber *)operand2
{
    return self.operationBlock(operand1, operand2);
}


@end
