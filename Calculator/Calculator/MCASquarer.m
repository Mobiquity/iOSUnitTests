//
//  MCASquarer.m
//  Calculator
//
//  Created by Chris Nielubowicz on 8/4/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCASquarer.h"

@interface MCASquarer ()

@property (nonatomic, strong, readwrite) NSDecimalNumber *operand;

@end

@implementation MCASquarer

- (id)initWithString:(NSString *)operand {
    if (self = [super init]) {
        _operand = [NSDecimalNumber decimalNumberWithString:operand];
    }
    return self;
}

@end
