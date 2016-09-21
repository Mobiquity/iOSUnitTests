//
//  NSString+MCAOperandStringUtils.m
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "NSString+MCAOperandStringUtils.h"

const NSUInteger MCAOperandMaxDigits = 25;
static NSString * const MCANegativeSignString = @"-";
static NSString * const MCADecimalPointString = @".";

NSString * const MCANotANumberString = @"NaN";
NSString * const MCAZeroString = @"0";

@implementation NSString (MCAOperandStringUtils)

-(NSString *)mca_stringByAppendingNumericInputType:(MCANumericInput)inputType
{
    NSMutableString *operandString = [self mutableCopy];
    
    switch (inputType) {
        case MCANumericInputZero:
            // do not add leading zeros
            if ([operandString isEqualToString:MCAZeroString]) {
                break;
            }
        case MCANumericInputOne:
        case MCANumericInputTwo:
        case MCANumericInputThree:
        case MCANumericInputFour:
        case MCANumericInputFive:
        case MCANumericInputSix:
        case MCANumericInputSeven:
        case MCANumericInputEight:
        case MCANumericInputNine:
            [operandString appendFormat:@"%lu", inputType];
            break;
        case MCANumericInputDecimalPoint:
            if (!self.length) {
                [operandString appendString:MCAZeroString];
            }
            [operandString appendString:MCADecimalPointString];
            break;
        case MCANumericInputSignChange:
            if (self.length) {
                if ([operandString rangeOfString:MCANegativeSignString].location == NSNotFound) {
                    [operandString insertString:MCANegativeSignString atIndex:0];
                } else {
                    [operandString deleteCharactersInRange:NSMakeRange(0, MCANegativeSignString.length)];
                }
            }
            break;
        default:
            NSLog(@"Unknown numeric input button type.");
            break;
    }
    return operandString;
}

- (NSDecimalNumber *)mca_toOperandNumber
{
    NSNumber *number = [[self.class mca_numberFormatter] numberFromString:self];
    return [number isKindOfClass:[NSDecimalNumber class]] ? (NSDecimalNumber *)number : [NSDecimalNumber notANumber];
}

+ (NSString *)mca_stringFromOperandNumber:(NSDecimalNumber *)operandNumber
{
    return (operandNumber == [NSDecimalNumber notANumber]) ? MCANotANumberString : [[self mca_numberFormatter] stringFromNumber:operandNumber];
}

+ (NSNumberFormatter *)mca_numberFormatter
{
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumSignificantDigits:MCAOperandMaxDigits];
        [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
        [numberFormatter setGeneratesDecimalNumbers:YES];
    });
    
    return numberFormatter;
}


@end
