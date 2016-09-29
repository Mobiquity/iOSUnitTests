//
//  MCACalculatorTests.m
//  Calculator
//
//  Created by Brendan Carey on 3/15/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"
#import "MCACalculator.h"

@interface MCACalculator (Testing)

@property (nonatomic, assign, readwrite, getter=isExpressionComplete) BOOL expressionComplete;
@property (nonatomic, strong) NSMutableArray<NSDecimalNumber *> *operands;
@property (nonatomic, strong) NSMutableArray<MCAOperator *> *operators;

@end

@interface MCACalculatorTests : MCABaseTestCase

@property (nonatomic, strong) MCACalculator *calculator;

@end

@implementation MCACalculatorTests

- (void)setUp {
    [super setUp];
    self.calculator = [[MCACalculator alloc] init];
}

- (void)testMCACalculator_evaluateExpressionHistoryOneOperand_operatesOnOperand
{
    // Arrange
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expected operation to operate on single operand."];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber minimumDecimalNumber];
    
    MCAOperator *operator = [[MCAOperator alloc] initWithPrecedence:0 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        if (operand1 == decimalNumber && operand2 == decimalNumber) {
            [expectation fulfill];
        }
        return operand1;
    }];
    
    self.calculator.operands = [NSMutableArray arrayWithObject:decimalNumber];
    self.calculator.operators = [NSMutableArray arrayWithObject:operator];
    
    // Act
    [self.calculator evaluateExpressionFromHistory];
    
    //Assert
    [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testMCACalculator_evaluateExpressionHistoryTwoOperators_performsHigherPrecedenceOperationFirst
{
    // Arrange
    NSDecimalNumber *expected = [NSDecimalNumber decimalNumberWithString:@"123.456"];
    
    MCAOperator *highPrecedenceOperator = [[MCAOperator alloc] initWithPrecedence:10 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return [NSDecimalNumber notANumber];
    }];
    
    MCAOperator *lowPrecendenceOperator = [[MCAOperator alloc] initWithPrecedence:5 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return expected;
    }];
    
    self.calculator.operands = [NSMutableArray arrayWithObjects:[NSDecimalNumber one], [NSDecimalNumber one], [NSDecimalNumber one], nil];
    self.calculator.operators = [NSMutableArray arrayWithObjects: lowPrecendenceOperator, highPrecedenceOperator, nil];
    
    // Act
    NSDecimalNumber *actual = [self.calculator evaluateExpressionFromHistory];
    
    //Assert
    XCTAssertEqualObjects(expected, actual, @"Expected higher precedence operator to operate first and final value to match lower precedence operator output.");
}


- (void)testMCACalculator_clearAllCalculatorHistory_shouldRemoveAllOperators
{
    // Arrange
    NSUInteger expected = 0;
    
    MCAOperator *highPrecedenceOperator = [[MCAOperator alloc] initWithPrecedence:10 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return [NSDecimalNumber zero];
    }];
    
    MCAOperator *lowPrecendenceOperator = [[MCAOperator alloc] initWithPrecedence:5 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return [NSDecimalNumber zero];
    }];
    
    self.calculator.operators = [NSMutableArray arrayWithObjects:highPrecedenceOperator, lowPrecendenceOperator, nil];
    [self.calculator clearAllCalculatorHistory];
    
    // Act
    NSUInteger actual = self.calculator.operators.count;
    
    //Assert
    XCTAssertEqual(expected, actual, @"Expected clear calculator history to empty calculator operators array.");
}

- (void)testMCACalculator_clearAllCalculatorHistory_shouldSetExpressionCompleteNO
{
    // Arrange
    self.calculator.expressionComplete = YES;
    [self.calculator clearAllCalculatorHistory];
    
    // Act
    BOOL expressionComplete = self.calculator.isExpressionComplete;
    
    //Assert
    XCTAssertFalse(expressionComplete, @"Expected clear calculator history to set expression complete to NO.");
}

- (void)testMCACalculator_evaluateExpressionFromHistory_shouldSetExpressionCompleteYES
{
    // Arrange
    self.calculator.expressionComplete = NO;
    [self.calculator evaluateExpressionFromHistory];
    
    // Act
    BOOL expressionComplete = self.calculator.isExpressionComplete;
    
    //Assert
    XCTAssertTrue(expressionComplete, @"Expected evaluating expression to set expression complete to YES.");
}

- (void)testMCACalculator_pushOperatorWithOperand_shouldNotSetExpressionComplete
{
    // Arrange
    self.calculator.expressionComplete = NO;
    
    MCAOperator *highPrecedenceOperator = [[MCAOperator alloc] initWithPrecedence:10 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return [NSDecimalNumber zero];
    }];
    
    MCAOperator *lowPrecendenceOperator = [[MCAOperator alloc] initWithPrecedence:5 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
        return [NSDecimalNumber zero];
    }];
    
    self.calculator.operators = [NSMutableArray arrayWithObjects:highPrecedenceOperator, nil];
    [self.calculator pushOperator:lowPrecendenceOperator withOperand:[NSDecimalNumber one]];
    
    // Act
    BOOL expressionComplete = self.calculator.isExpressionComplete;
    
    //Assert
    XCTAssertFalse(expressionComplete, @"Expected push operand with operator to not set expression complete.");
}

-(void) testMCACalculator_squareRootPositiveIntNumber_shouldSetValueToSquareRoot{
    // Arrange
    NSString *expected = @"2.000000";
    
    // Act
    NSString *actual = [self.calculator getSquareRoot:@"4"];
    
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Strings are not equal %@ %@", expected,  actual);
}
-(void) testMCACalculator_squareRootPositiveRealNumber_shouldSetValueToSquareRoot{
    // Arrange
    NSString *expected = @"8.800000";
    
    // Act
    NSString *actual = [self.calculator getSquareRoot:@"77.44"];
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Strings are not equal %@ %@", expected,  actual);
}
-(void) testMCACalculator_squareRootZeroNumber_shouldSetValueToSquareRoot{
    // Arrange
    NSString *expected = @"0.000000";
    
    // Act
    NSString *actual = [self.calculator getSquareRoot:@"0"];
    
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Strings are not equal %@ %@", expected,  actual);
}

-(void) testMCACalculator_factorialPositiveNumber_shouldSetValueTo {
    // Arrange
    NSString *expected = @"24.000000";
    
    // Act
    NSString *actual = [self.calculator factorial:@"4"];
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Factorial Positive - Strings are not equal %@ %@", expected,  actual);
}

-(void) testMCACalculator_factorialPositiveRealNumber_shouldSetValueTo {
    // Arrange
    NSString *expected = @"52.342777";
    
    // Act
    NSString *actual = [self.calculator factorial:@"4.5"];
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Factorial Positive RealNumber - Strings are not equal %@ %@", expected,  actual);
}

-(void) testMCACalculator_factorialZeroNumber_shouldSetValueTo {
    // Arrange
    NSString *expected = @"1.000000";
    
    // Act
    NSString *actual = [self.calculator factorial:@"0.0"];
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Factorial Zero Number - Strings are not equal %@ %@", expected,  actual);
}

-(void) testMCACalculator_factorialNegativeNumber_shouldSetValueTo {
    // Arrange
    NSString *expected = @"Error";
    
    // Act
    NSString *actual = [self.calculator factorial:@"-5.0"];
    
    //Assert
    XCTAssertTrue([actual isEqualToString:expected],
                  @"Factorial Negative Number - Strings are not equal %@ %@", expected,  actual);
}


@end
