//
//  MCAHalloweenButton.m
//  Calculator
//
//  Created by Adriana Ormaetxea Arregi on 28/09/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAHalloweenButton.h"

@implementation MCAHalloweenButton

@synthesize isHalloweenMode = _isHalloweenMode;
@synthesize calculatorButtonType = _calculatorButtonType;


-(BOOL)isHalloweenMode
{
    return self.isHalloweenMode;
}

-(void)setIsHalloweenMode:(BOOL)isHalloweenMode
{

    _isHalloweenMode = isHalloweenMode;
    if (!isHalloweenMode)
    {
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        switch (_calculatorButtonType) {
            case MCAButtonTopGrayType:
                self.backgroundColor = [UIColor darkGrayColor];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                break;
            case MCAButtonCenterGrayType:
                self.backgroundColor = [UIColor lightGrayColor];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                break;
            case MCAButtonOrangeType:
                self.backgroundColor = [UIColor orangeColor];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                break;
                
            default:
                self.backgroundColor = [UIColor redColor];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                [self setTitle:@"Scary" forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont fontWithName:@"Gypsy Curse" size:42];
                break;
        }

            }
    else
    {
        self.titleLabel.font = [UIFont fontWithName:@"Gypsy Curse" size:42];
        switch (_calculatorButtonType) {
            case MCAButtonTopGrayType:
                self.backgroundColor = [UIColor blackColor];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                break;
            case MCAButtonCenterGrayType:
                self.backgroundColor = [UIColor purpleColor];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                break;
            case MCAButtonOrangeType:
                self.backgroundColor = [UIColor redColor];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                break;
                
            default://ScaryButton
                self.backgroundColor = [UIColor grayColor];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                [self setTitle:@"Boring" forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];

                break;
        }

          }
}

-(void)setCalculatorButtonType:(NSInteger)value
{
    _calculatorButtonType = (MCAButtonType) value;
}

-(NSInteger)calculatorButtonType{
    return _calculatorButtonType;
}


@end
