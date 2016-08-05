//
//  MCAColorChanger.m
//  Calculator
//
//  Created by Chris Nielubowicz on 8/5/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAColorChanger.h"

static NSString *const colorKey = @"MCAColor";

@interface MCAColorChanger()
@property (nonatomic, readwrite) BOOL changeColors;

- (void)setChangeColors:(BOOL)changeColors;

@end

@implementation MCAColorChanger

- (id)init {
    if (self = [super init]) {
        _changeColors = [[NSUserDefaults standardUserDefaults] boolForKey:colorKey] ?: NO;
    }
    return self;
}

- (BOOL)toggle {
    [self setChangeColors:!self.changeColors];
    return self.changeColors;
}

- (UIColor *)currentColor {
    if (self.changeColors) {
        return self.onColor;
    } else {
        return self.offColor;
    }
}

- (UIColor *)onColor {
    return UIColor.redColor;
}

- (UIColor *)offColor {
    return UIColor.cyanColor;
}

- (void)setChangeColors:(BOOL)changeColors {
    _changeColors = changeColors;
    [[NSUserDefaults standardUserDefaults] setBool:changeColors forKey:colorKey];
}

@end
