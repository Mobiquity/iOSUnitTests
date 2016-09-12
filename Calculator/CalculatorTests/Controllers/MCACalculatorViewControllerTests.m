//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"

#import "MCACalculatorViewController.h"
#import "NSString+MCAOperandStringUtils.h"
#import "MCACalculator.h"

#import <OCMock/OCMock.h>

@interface MCACalculatorViewController (Testing)

@property (nonatomic, copy) NSString *operandString;
@property (nonatomic, weak) IBOutlet UILabel *calculatorDisplayLabel;
@property (nonatomic, strong) MCACalculator *calculator;
@property (nonatomic, strong) NSMutableArray<MCAOperator *> *operators;

- (IBAction)numericInputButtonTapped:(id)sender;
- (IBAction)clearButtonTapped:(id)sender;
- (IBAction)operatorButtonTapped:(UIButton *)sender;
- (NSMutableArray *)createOperators;
- (IBAction)squarerootButtonTapped:(id)sender;
@end

@interface CalculatorTests : MCABaseTestCase

@property (nonatomic, strong) MCACalculatorViewController *calculatorViewController;

@end

@implementation CalculatorTests

-(void)setUp
{
    [super setUp];
    self.calculatorViewController = [[MCACalculatorViewController alloc] init];
}

- (void)testMCACalculatorViewController_inputButtonTappedOperandStringOverDigitLimit_shouldNotSetLabelText
{
    // Arrange
    NSMutableString *overDigitLimitOperandString = [NSMutableString string];
    for (NSInteger i = 0; i < MCAOperandMaxDigits + 1; i++) {
        [overDigitLimitOperandString appendString:@"5"];
    }
    self.calculatorViewController.operandString = overDigitLimitOperandString;
    
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel reject] setText:OCMOCK_ANY];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    UIButton *sevenDigitButton = [[UIButton alloc] init];
    sevenDigitButton.tag = MCANumericInputSeven;
    
    // Act
    [self.calculatorViewController numericInputButtonTapped:sevenDigitButton];
    
    //Assert
    [mockLabel verify];
}

- (void)testMCACalculatorViewController_inputButtonTappedOperandStringUnderDigitLimit_setsLabelText
{
    // Arrange
    NSMutableString *underDigitLimitOperandString = [NSMutableString string];
    for (NSInteger i = 0; i < MCAOperandMaxDigits - 1; i++) {
        [underDigitLimitOperandString appendString:@"5"];
    }
    self.calculatorViewController.operandString = underDigitLimitOperandString;
    
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel expect] setText:OCMOCK_ANY];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    UIButton *sevenDigitButton = [[UIButton alloc] init];
    sevenDigitButton.tag = MCANumericInputSeven;
    
    // Act
    [self.calculatorViewController numericInputButtonTapped:sevenDigitButton];
    
    //Assert
    [mockLabel verify];
}

- (void)testMCACalculatorViewController_inputButtonTappedOperandStringAtDigitLimit_shouldNotSetLabelText
{
    // Arrange
    NSMutableString *digitLimitOperandString = [NSMutableString string];
    for (NSInteger i = 0; i < MCAOperandMaxDigits; i++) {
        [digitLimitOperandString appendString:@"5"];
    }
    self.calculatorViewController.operandString = digitLimitOperandString;
    
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel reject] setText:OCMOCK_ANY];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    UIButton *sevenDigitButton = [[UIButton alloc] init];
    sevenDigitButton.tag = MCANumericInputSeven;
    
    // Act
    [self.calculatorViewController numericInputButtonTapped:sevenDigitButton];
    
    //Assert
    [mockLabel verify];
}


- (void)testMCACalculatorViewController_numericInputButtonTappedInvalidOperandString_shouldNotSetLabelText
{
    // Arrange
    id mockStringUtils = [OCMockObject niceMockForClass:[NSString class]];
    [[[mockStringUtils stub] andReturn:nil] mca_toOperandNumber];
    
    [[[[mockStringUtils stub] ignoringNonObjectArgs] andReturn:mockStringUtils] mca_stringByAppendingNumericInputType:0];
    
    self.calculatorViewController.operandString = mockStringUtils;
    
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel reject] setText:OCMOCK_ANY];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    UIButton *sevenDigitButton = [[UIButton alloc] init];
    sevenDigitButton.tag = MCANumericInputSeven;
     
    // Act
    [self.calculatorViewController numericInputButtonTapped:sevenDigitButton];
    
    //Assert
    [mockLabel verify];
}


- (void)testMCACalculatorViewController_numericInputButtonTappedValidOperandString_shouldSetLabelText
{
    // Arrange
    id mockStringUtils = [OCMockObject niceMockForClass:[NSString class]];
    [[[mockStringUtils stub] andReturn:[NSDecimalNumber maximumDecimalNumber]] mca_toOperandNumber];
    
    [[[[mockStringUtils stub] ignoringNonObjectArgs] andReturn:mockStringUtils] mca_stringByAppendingNumericInputType:0];
    
    self.calculatorViewController.operandString = mockStringUtils;
    
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel expect] setText:mockStringUtils];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    UIButton *sevenDigitButton = [[UIButton alloc] init];
    sevenDigitButton.tag = MCANumericInputSeven;
    
    // Act
    [self.calculatorViewController numericInputButtonTapped:sevenDigitButton];
    
    //Assert
    [mockLabel verify];
}


- (void)testMCACalculatorViewController_clearButtonTapped_shouldClearCalculatorHistory
{
    // Arrange
    id mockCalculator = [OCMockObject niceMockForClass:[MCACalculator class]];
    [[mockCalculator expect] clearAllCalculatorHistory];
    
    self.calculatorViewController.calculator = mockCalculator;
    
    // Act
    [self.calculatorViewController clearButtonTapped:nil];
    
    //Assert
    [mockCalculator verify];
}


- (void)testMCACalculatorViewController_operatorButtonTappedUnknownOperator_doesNowUpdateLabelText
{
    // Arrange
    id mockLabel = [OCMockObject niceMockForClass:[UILabel class]];
    [[mockLabel reject] setText:OCMOCK_ANY];
    self.calculatorViewController.calculatorDisplayLabel = mockLabel;
    
    self.calculatorViewController.operators = [self.calculatorViewController createOperators];
    
    // Act
    UIButton *unknownOperatorButton = [[UIButton alloc] init];
    unknownOperatorButton.tag = MCAOperatorTypeCount;
    
    //Assert
    [self.calculatorViewController operatorButtonTapped:unknownOperatorButton];
}


@end
