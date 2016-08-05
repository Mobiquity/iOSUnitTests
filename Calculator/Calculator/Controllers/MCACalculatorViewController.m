//
//  MCACalculatorViewController.m
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCACalculatorViewController.h"

#import "MCACalculator.h"
#import "MCAOperator.h"

#import "NSString+MCAOperandStringUtils.h"

@interface MCACalculatorViewController ()

@property (nonatomic, weak) IBOutlet UILabel *calculatorDisplayLabel;
@property (nonatomic, weak) IBOutlet UIButton *clearButton;

@property (nonatomic, copy) NSString *operandString;

@property (nonatomic, strong) MCACalculator *calculator;
@property (nonatomic, strong) NSMutableArray<MCAOperator *> *operators;

@end

@implementation MCACalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calculator = [[MCACalculator alloc] init];
    self.operators = [self createOperators];
}

- (NSMutableArray *)createOperators {
    NSMutableArray *operatorArray = [NSMutableArray array];
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:25 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    for (NSUInteger i = 0; i < MCAOperatorTypeCount; i++) {
        switch(i) {
            case MCAOperatorTypeAddition: {
                [operatorArray addObject:[[MCAOperator alloc] initWithPrecedence:10 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
                                                                      return [operand1 decimalNumberByAdding:operand2 withBehavior:decimalNumberHandler];
                                                                  }]];
                break;
            }
            case MCAOperatorTypeSubtraction: {
                [operatorArray addObject:[[MCAOperator alloc] initWithPrecedence:10 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
                                                                      return [operand1 decimalNumberBySubtracting:operand2 withBehavior:decimalNumberHandler];
                                                                  }]];
                break;
            }
            case MCAOperatorTypeMultiplication: {
                [operatorArray addObject:[[MCAOperator alloc] initWithPrecedence:20 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
                                                                      return [operand1 decimalNumberByMultiplyingBy:operand2 withBehavior:decimalNumberHandler];
                                                                  }]];
                break;
            }
            case MCAOperatorTypeDivision: {
                [operatorArray addObject:[[MCAOperator alloc] initWithPrecedence:20 operationBlock:^NSDecimalNumber * _Nonnull(NSDecimalNumber * _Nonnull operand1, NSDecimalNumber * _Nonnull operand2) {
                                                                      return [operand1 decimalNumberByDividingBy:operand2 withBehavior:decimalNumberHandler];
                                                                  }]];
                break;
            }
        }
    }
    return operatorArray;
}

- (void)setOperandString:(NSString *)operandString
{
    _operandString = operandString;
    self.calculatorDisplayLabel.text = self.operandString ?: MCAZeroString;
}

- (IBAction)clearButtonTapped:(id)sender
{
    [self.calculator clearAllCalculatorHistory];
    self.operandString = nil;
    self.calculatorDisplayLabel.text = MCAZeroString;
}

- (IBAction)numericInputButtonTapped:(UIButton *)sender
{
    NSString *operandString = [(self.operandString ?: [NSString string]) mca_stringByAppendingNumericInputType:sender.tag];
    [self handleInput:sender.tag baseString:operandString];
}

- (IBAction)signChangeButtonTapped:(UIButton *)sender
{
    BOOL startingNewExpression = self.calculator.isExpressionComplete;
    NSString *operandString = [(self.operandString ?: self.calculatorDisplayLabel.text) mca_stringByAppendingNumericInputType:sender.tag];
    [self handleInput:MCANumericInputSignChange baseString:operandString];
    
    if (startingNewExpression) {
        [self.calculator pushOperand:[self.operandString mca_toOperandNumber]];
    }
}

- (void)handleInput:(MCANumericInput)inputType baseString:(NSString *)baseString
{
    if (baseString.length <= MCAOperandMaxDigits && [baseString mca_toOperandNumber]) {
        if (self.calculator.isExpressionComplete) {
            // starting a new expression
            [self.calculator clearAllCalculatorHistory];
        }
        self.operandString = baseString;
    }
}

- (IBAction)operatorButtonTapped:(UIButton *)sender
{
    if (self.operators.count > sender.tag) {
        NSDecimalNumber *operand = [self.operandString mca_toOperandNumber];
        NSDecimalNumber *result;
        if (operand) {
            result = [self.calculator pushOperator:self.operators[sender.tag] withOperand:operand];
        } else {
            [self.calculator clearAllCalculatorHistory];
            result = [self.calculator pushOperator:self.operators[sender.tag] withOperand:[self.calculatorDisplayLabel.text mca_toOperandNumber]];
        }
        self.operandString = nil;
        self.calculatorDisplayLabel.text = [NSString mca_stringFromOperandNumber:result];
    }
}

- (IBAction)equalsButtonTapped:(id)sender
{
    NSDecimalNumber *result;
    NSDecimalNumber *operand = [self.operandString mca_toOperandNumber] ?: [self.calculatorDisplayLabel.text mca_toOperandNumber];
    if (operand) {
        result = [self.calculator pushOperand:operand];
    } else {
        result = [self.calculator evaluateExpressionFromHistory];
    }
    self.operandString = nil;
    self.calculatorDisplayLabel.text = [NSString mca_stringFromOperandNumber:result];
}

-(IBAction)unwindToCalculatorViewController:(UIStoryboardSegue *)sender {}

#pragma mark - New Testable Action

-(IBAction)changeColorTapped:(id)sender {
    
}

// TODO: Add IBAction for your testable action
// TODO: Add testable classes and methods

@end
