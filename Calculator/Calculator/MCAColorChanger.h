//
//  MCAColorChanger.h
//  Calculator
//
//  Created by Chris Nielubowicz on 8/5/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

@import UIKit;

@interface MCAColorChanger : NSObject

@property (nonatomic, readonly) UIColor *onColor;
@property (nonatomic, readonly) UIColor *offColor;
@property (nonatomic, readonly) BOOL changeColors;

- (BOOL)toggle;
- (UIColor *)currentColor;

@end
