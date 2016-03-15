//
//  MCAWolframAlphaSectionData.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/13/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAWolframAlphaSectionData.h"

@interface MCAWolframAlphaSectionData ()

@property (copy, nonatomic, readwrite) NSArray *data;
@property (copy, nonatomic, readwrite) NSString *title;

@end

@implementation MCAWolframAlphaSectionData

- (instancetype)initWithData:(NSArray *)data title:(NSString *)title {
    if (self = [super init]) {
        _data = data;
        _title = title;
    }
    return self;
}

@end