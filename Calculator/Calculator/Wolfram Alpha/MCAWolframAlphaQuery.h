//
//  MCAWolframAlphaQuery.h
//  Calculator
//
//  Created by Chris Nielubowicz on 3/3/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const wolframAlphaQueryString;

@interface MCAWolframAlphaQuery : NSObject

- (instancetype)initWithQueryText:(NSString *)query NS_DESIGNATED_INITIALIZER;
- (NSURL *)queryURL;

@end
