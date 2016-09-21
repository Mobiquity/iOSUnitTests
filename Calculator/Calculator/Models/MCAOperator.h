//
//  MCAOperator.h
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright (c) 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSDecimalNumber  * _Nonnull (^MCABinaryOperationBlock)(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2);

@interface MCAOperator : NSObject

@property (nonatomic, readonly) NSUInteger precedence;

- (_Nullable instancetype)initWithPrecedence:(NSUInteger)precedence operationBlock:(_Nonnull MCABinaryOperationBlock)operationBlock;
- (NSDecimalNumber * _Nonnull)operateOnOperand1:(NSDecimalNumber * _Nonnull)operand1 operand2:(NSDecimalNumber * _Nonnull)operand2;

@end
