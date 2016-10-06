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
#import "MCAHalloweenButton.h"
#import "NSString+MCAOperandStringUtils.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MCACalculatorViewController ()

@property (nonatomic, weak) IBOutlet UILabel *calculatorDisplayLabel;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *clearButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *squareRootButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *acButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *signButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *percentageButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *divisionButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *timesButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *substractButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *sumButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *equalsButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *dotButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *oneButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *twoButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *threeButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *fourButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *fiveButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *sixButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *sevenButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *eightButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *nineButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *zeroButton;
@property (nonatomic, weak) IBOutlet MCAHalloweenButton *wolframButton;
@property (nonatomic, weak) IBOutlet UIImageView *haloweenSurprise;


@property (nonatomic, copy) NSString *operandString;

@property (nonatomic, strong) MCACalculator *calculator;
@property (nonatomic, strong) NSMutableArray<MCAOperator *> *operators;
@property (nonatomic, assign) BOOL isHalloweendModeOn;
@property (nonatomic, retain) IBOutletCollection(MCAHalloweenButton) NSArray *buttons;



@end

@implementation MCACalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calculator = [[MCACalculator alloc] init];
    self.operators = [self createOperators];
    self.isHalloweendModeOn = NO;
    [self changeHalloweenMode:NO];

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

- (IBAction)squarerootButtonTapped:(id)sender
{
    self.calculatorDisplayLabel.text= [self.calculator getSquareRoot: self.calculatorDisplayLabel.text];
    if (![self.calculatorDisplayLabel.text  isEqual: @"ERROR"])
    {
        self.operandString = self.calculatorDisplayLabel.text;
    }
    else {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(setDisplayToZero)
                                       userInfo:nil
                                        repeats:NO];
    }
}

-(void) setDisplayToZero
{
    self.calculatorDisplayLabel.text = @"0";
    self.operandString = @"0";
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

    
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
        //HALLOWEEN SURPRISE
        if (result == nil) {
            self.haloweenSurprise.hidden = NO;
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Howie-scream" ofType:@"mp3"];
            SystemSoundID soundID;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
            AudioServicesPlaySystemSound(soundID);
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

- (IBAction)halloweenButtonTapped:(UIButton *)sender
{
    [self changeHalloweenMode:!self.isHalloweendModeOn];
    self.isHalloweendModeOn = !self.isHalloweendModeOn;
}
-(void)changeHalloweenMode:(BOOL)isHalloween
{
    for (MCAHalloweenButton * button in self.buttons)
    {
        button.isHalloweenMode = isHalloween;
    }
    self.calculatorDisplayLabel.font = isHalloween? [UIFont fontWithName:@"Gypsy Curse" size:52]: [UIFont fontWithName:@"HelveticaNeue-Light" size:52];
    self.calculator.isHalloweenMode = isHalloween;
    self.haloweenSurprise.hidden = YES;
}

-(IBAction)unwindToCalculatorViewController:(UIStoryboardSegue *)sender {}

@end
