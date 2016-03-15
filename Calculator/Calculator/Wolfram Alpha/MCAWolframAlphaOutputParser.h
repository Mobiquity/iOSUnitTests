//
//  MCAWolframAlphaOutputParser.h
//  Calculator
//
//  Created by Chris Nielubowicz on 3/10/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCAWolframAlphaSectionData;

typedef void (^OutputCompletion)(NSArray<MCAWolframAlphaSectionData *> *content, NSError *error);

@interface MCAWolframAlphaOutputParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic, readonly) NSXMLParser *parser;

- (instancetype)initWithData:(NSData *)data;
- (void)parseWithCompletion:(OutputCompletion)completion;

@end
