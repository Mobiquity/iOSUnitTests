//
//  NSString+MCAOperandStringUtils.h
//  Calculator
//
//  Created by Brendan Carey on 3/14/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MCAZeroString;
extern const NSUInteger MCAOperandMaxDigits;
extern NSString * const MCANotANumberString;


typedef NS_ENUM(NSUInteger, MCANumericInput) {
    MCANumericInputZero,
    MCANumericInputOne,
    MCANumericInputTwo,
    MCANumericInputThree,
    MCANumericInputFour,
    MCANumericInputFive,
    MCANumericInputSix,
    MCANumericInputSeven,
    MCANumericInputEight,
    MCANumericInputNine,
    MCANumericInputDecimalPoint,
    MCANumericInputSignChange
};

@interface NSString (MCAOperandStringUtils)

- (NSString *)mca_stringByAppendingNumericInputType:(MCANumericInput)inputType;
- (NSDecimalNumber *)mca_toOperandNumber;
+ (NSString *)mca_stringFromOperandNumber:(NSDecimalNumber *)operandNumber;

@end
