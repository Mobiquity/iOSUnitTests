//
//  MCAWolframAlphaDataSource.h
//  Calculator
//
//  Created by Chris Nielubowicz on 3/13/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

@import UIKit;

@class MCAWolframAlphaSectionData;

@interface MCAWolframAlphaDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithWolframPods:(NSArray<MCAWolframAlphaSectionData *> *)pods;

@end