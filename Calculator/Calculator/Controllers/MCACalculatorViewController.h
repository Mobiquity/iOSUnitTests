//
//  MCACalculatorViewController.h
//  Calculator
//
//  Created by Brendan Carey on 2/29/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MCAOperatorType) {
    MCAOperatorTypeAddition,
    MCAOperatorTypeSubtraction,
    MCAOperatorTypeMultiplication,
    MCAOperatorTypeDivision,
    MCAOperatorTypeExponent,
    MCAOperatorTypeCount
};

@interface MCACalculatorViewController : UIViewController

@end

