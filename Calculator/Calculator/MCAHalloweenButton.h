//
//  MCAHalloweenButton.h
//  Calculator
//
//  Created by Adriana Ormaetxea Arregi on 28/09/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCAButtonType) {
    MCAButtonTopGrayType = 0,
    MCAButtonCenterGrayType = 1,
    MCAButtonOrangeType = 2
};

@interface MCAHalloweenButton : UIButton
@property (nonatomic) IBInspectable NSInteger calculatorButtonType;
@property (nonatomic) IBInspectable BOOL isHalloweenMode;

@end
