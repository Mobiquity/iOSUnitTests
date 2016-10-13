//
//  MCACalculator.m
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright (c) 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCACalculator.h"
#import "limits.h"

@interface MCACalculator ()

@property (nonatomic, assign, readwrite, getter=isExpressionComplete) BOOL expressionComplete;
@property (nonatomic, strong) NSMutableArray<NSDecimalNumber *> *operands;
@property (nonatomic, strong) NSMutableArray<MCAOperator *> *operators;

@end

@implementation MCACalculator

-(instancetype)init
{
    if (self = [super init]) {
        _operands = [NSMutableArray array];
        _operators = [NSMutableArray array];
        
    }
    return self;
}

- (void)pushOperator:(MCAOperator *)operator
{
    [self.operators addObject:operator];
}

-(NSDecimalNumber *)pushOperator:(MCAOperator *)operator withOperand:(NSDecimalNumber *)operand
{
    NSDecimalNumber *retObj = operand;
    MCAOperator *previousOperator = [self.operators lastObject];
    [self.operands addObject:operand];
    [self.operators addObject:operator];
    
    if (previousOperator && previousOperator.precedence >= operator.precedence) {
        // expression can be simplified
        retObj = [self simplifyOperators:[self.operators mutableCopy] forOperands:[self.operands mutableCopy]];
        // keep the result and the most recent operation
        self.operands = [NSMutableArray arrayWithObjects:retObj, nil];
        self.operators = [NSMutableArray arrayWithObjects:[self.operators lastObject], nil];
    }
        
    return retObj;
}

- (NSDecimalNumber *)pushOperand:(NSDecimalNumber *)operand
{
    NSDecimalNumber *retObj = operand;
    if (self.operators.count) {
        if (self.operands.count > self.operators.count) {
            [self.operands replaceObjectAtIndex:0 withObject:operand];
        } else {
            [self.operands addObject:operand];
        }
        retObj = [self evaluateExpressionFromHistory];
        // keep the most recent operation/operand in order to repeat
        self.operands = [NSMutableArray arrayWithObjects:retObj, [self.operands lastObject], nil];
        self.operators = [NSMutableArray arrayWithObjects:[self.operators lastObject], nil];

    }
    return retObj;
}

- (NSDecimalNumber *)evaluateExpressionFromHistory
{
    self.expressionComplete = YES;
    return [self simplifyOperators:[self.operators mutableCopy] forOperands:[self.operands mutableCopy]];
}

- (NSDecimalNumber *)simplifyOperators:(NSMutableArray <MCAOperator *> *)operators forOperands:(NSMutableArray <NSDecimalNumber *> *)operands
{
    if (operands.count <= 2) {
        return [[operators firstObject] operateOnOperand1:[operands firstObject] operand2:[operands lastObject]];
    }
    NSUInteger maxPrecedence = [[operators valueForKeyPath:@"@max.precedence"] integerValue];
    MCAOperator *operator = [[operators filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"precedence = %d", maxPrecedence]] firstObject];
    NSUInteger index = [operators indexOfObject:operator];
    
    NSDecimalNumber *operand1 = operands[index];
    NSDecimalNumber *operand2 = operands[index + 1];
    
    [operands replaceObjectAtIndex:index withObject:[operator operateOnOperand1:operand1 operand2:operand2]];
    [operands removeObjectAtIndex:index + 1];
    [operators removeObjectAtIndex:index];
    
    return [self simplifyOperators:operators forOperands:operands];
    
}
-(NSString *)getSquareRoot: (NSString *)radicand
{
    if ([radicand floatValue] >= 0)
    {
       radicand = [NSString stringWithFormat:@"%f", sqrt([radicand floatValue])];
    }
    else {
        radicand = @"ERROR";
    }
    return radicand;

}


- (void)clearAllCalculatorHistory
{
    self.expressionComplete = NO;
    [self.operators removeAllObjects];
    [self.operands removeAllObjects];
}

- (NSString *)squareNumber:(NSString *)numberToSquare
{
    if (numberToSquare == nil) {
        return @"ERROR";
    }
    NSScanner *scan = [NSScanner scannerWithString: numberToSquare];
    [scan setCharactersToBeSkipped:[[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet]];
    float f;
    if ([scan scanFloat:&f]) {
        return @"NaN";
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSDecimalNumber* numberToSquareDecimalNumber = [NSDecimalNumber decimalNumberWithString: numberToSquare];
//    numberToSquare = [NSString stringWithFormat:@"%f", [numberToSquare doubleValue] * [numberToSquare doubleValue]];
    numberToSquare = [NSString stringWithFormat:@"%@", [numberToSquareDecimalNumber decimalNumberByMultiplyingBy:numberToSquareDecimalNumber]];
    [numberFormatter numberFromString:numberToSquare];
    return numberToSquare;
}



@end
