//
//  MCAWolframAlphaSectionData.h
//  Calculator
//
//  Created by Chris Nielubowicz on 3/13/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCAWolframAlphaSectionData : NSObject

@property (copy, nonatomic, readonly) NSArray *data;
@property (copy, nonatomic, readonly) NSString *title;

- (instancetype)initWithData:(NSArray *)data title:(NSString *)title;

@end
