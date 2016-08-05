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
    if (operand == nil || [operand isKindOfClass:[NSString class]] == false) {
        return nil;
    }
    
    if (self = [super init]) {
        _operand = [NSDecimalNumber decimalNumberWithString:operand];
        if (_operand == nil || [_operand isEqualToNumber:[NSDecimalNumber notANumber]]) {
            return nil;
        }
    }
    
    return self;
}

@end
