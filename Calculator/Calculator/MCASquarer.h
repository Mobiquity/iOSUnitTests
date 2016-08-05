//
//  MCASquarer.h
//  Calculator
//
//  Created by Chris Nielubowicz on 8/4/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCASquarer : NSObject

@property (nonatomic, strong, readonly) NSDecimalNumber *operand;

- (id)initWithString:(NSString *)operand;

- (NSDecimalNumber *)squared;
- (NSString *)formattedSquaredString;

@end
