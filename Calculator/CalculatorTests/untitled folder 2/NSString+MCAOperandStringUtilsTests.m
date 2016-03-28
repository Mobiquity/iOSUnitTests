//
//  NSString+MCAOperandStringUtilsTests.m
//  Calculator
//
//  Created by Brendan Carey on 3/15/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"
#import "NSString+MCAOperandStringUtils.h"

@interface NSString_MCAOperandStringUtilsTests : MCABaseTestCase

@end

@implementation NSString_MCAOperandStringUtilsTests

- (void)testMCAOperandStringUtils_nonNumericStringToOperand_returnsNaN
{
    // Arrange
    NSDecimalNumber *expected = [NSDecimalNumber notANumber];
    NSString *nonNumericOperandString = @"123a5";
    
    // Act
    NSDecimalNumber *actual = [nonNumericOperandString mca_toOperandNumber];
    
    //Assert
    XCTAssertEqual(expected , actual, @"Expected non-numeric string to operand to return NaN.");
}

- (void)testMCAOperandStringUtils_numericStringToOperand_returnsObject
{
    // Arrange
    NSString *numericOperandString = @"13579";
    
    // Act
    NSDecimalNumber *decimalNumber = [numericOperandString mca_toOperandNumber];
    
    //Assert
    XCTAssertNotNil(decimalNumber);
}

- (void)testMCAOperandStringUtils_decimalNumericStringToOperand_returnsObject
{
    // Arrange
    NSString *decimalNumericOperandString = @"13579.11131517";
    
    // Act
    NSDecimalNumber *decimalNumber = [decimalNumericOperandString mca_toOperandNumber];
    
    //Assert
    XCTAssertNotNil(decimalNumber);
}

- (void)testMCAOperandStringUtils_twoDecimalPointsStringToOperand_returnsNaN
{
    // Arrange
    NSDecimalNumber *expected = [NSDecimalNumber notANumber];
    NSString *twoDecimalPointsOperandString = @"13579.1113.1517";
    
    // Act
    NSDecimalNumber *actual = [twoDecimalPointsOperandString mca_toOperandNumber];
    
    //Assert
    XCTAssertEqual(expected , actual, @"Expected non-numeric string to operand to return NaN.");
}

- (void)testMCAOperandStringUtils_negativeNumericStringToOperand_returnsObject
{
    // Arrange
    NSString *negativeNumericOperandString = @"-13579";
    
    // Act
    NSDecimalNumber *decimalNumber = [negativeNumericOperandString mca_toOperandNumber];
    
    //Assert
    XCTAssertNotNil(decimalNumber);
}

- (void)testMCAOperandStringUtils_appendingZeroToZeroString_returnsZeroString
{
    // Arrange
    NSString *expected = MCAZeroString;
    
    // Act
    NSString *actual = [MCAZeroString mca_stringByAppendingNumericInputType:MCANumericInputZero];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected appending zero to zero operand string to return zero string instead of adding leading zeros.");
}

- (void)testMCAOperandStringUtils_appendingZeroToNonzeroString_returnsCorrectString
{
    // Arrange
    NSString *input = @"135";
    NSString *expected = [input stringByAppendingString:@"0"];
    
    // Act
    NSString *actual = [input mca_stringByAppendingNumericInputType:MCANumericInputZero];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected appending zero to nonzero operand string to append zero.");
}

- (void)testMCAOperandStringUtils_appendingDecimalPointToEmptyString_returnsZeroPaddedDecimalString
{
    // Arrange
    NSString *expected = @"0.";
    
    // Act
    NSString *actual = [@"" mca_stringByAppendingNumericInputType:MCANumericInputDecimalPoint];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected appending decimal point to empty operand string to yield zero padded decimal point string.");
}

- (void)testMCAOperandStringUtils_appendingDecimalPointToNonEmptyString_doesNotAppendZeroBeforeDecimalPoint
{
    // Arrange
    NSString *input = @"1357";
    NSString *expected = [input stringByAppendingString:@"."];
    
    // Act
    NSString *actual = [input mca_stringByAppendingNumericInputType:MCANumericInputDecimalPoint];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected appending decimal point to non-empty operand string to yield correct string.");
}

- (void)testMCAOperandStringUtils_signChangeOnPositiveNumberString_prependsHyphen
{
    // Arrange
    NSString *input = @"1357";
    NSString *expected = [@"-" stringByAppendingString:input];
    
    // Act
    NSString *actual = [input mca_stringByAppendingNumericInputType:MCANumericInputSignChange];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected sign change on positive number operand string to yield correct negative number string.");
}

- (void)testMCAOperandStringUtils_signChangeOnNegativeNumberString_removesHyphen
{
    // Arrange
    NSString *expected = @"1357";
    NSString *input = [@"-" stringByAppendingString:expected];
    
    // Act
    NSString *actual = [input mca_stringByAppendingNumericInputType:MCANumericInputSignChange];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected sign change on negative number operand string to yield correct positive number string.");
}

- (void)testMCAOperandStringUtils_appendingUnknownNumericInputType_doesNotModifyString
{
    // Arrange
    NSString *expected = @"1357";
    
    // Act
    NSString *actual = [expected mca_stringByAppendingNumericInputType:-1];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected appending unknown numeric input type to not modify string.");
}

- (void)testMCAOperandStringUtils_stringFromOperandNumberNaN_returnsNaNString
{
    // Arrange
    NSString *expected = MCANotANumberString;
    
    // Act
    NSString *actual = [NSString mca_stringFromOperandNumber:[NSDecimalNumber notANumber]];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected string from notANumber to return NaN string.");
}


@end
