//
//  MCASquarer.h
//  Calculator
//
//  Created by Chris Nielubowicz on 8/4/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCASquarer : NSObject

@property (nonnull, nonatomic, strong, readonly) NSDecimalNumber *operand;

- (nullable id)initWithString:(nullable NSString *)operand;

- (nonnull NSDecimalNumber *)squared;
- (nonnull NSString *)formattedSquaredString;

@end
