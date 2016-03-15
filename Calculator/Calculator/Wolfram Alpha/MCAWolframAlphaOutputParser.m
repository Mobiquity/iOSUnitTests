//
//  MCAWolframAlphaOutputParser.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/10/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAWolframAlphaOutputParser.h"
#import "MCAWolframAlphaSectionData.h"

@interface MCAWolframAlphaOutputParser()

@property (copy, nonatomic) NSData *XMLData;
@property (strong, nonatomic, readwrite) NSXMLParser *parser;
@property (strong, nonatomic) OutputCompletion completion;

@property (strong, nonatomic) NSMutableArray *pods;
@property (strong, nonatomic) NSMutableArray *podData;
@property (strong, nonatomic) NSString *podTitle;

@property (assign, nonatomic) BOOL parseFoundString;

@end

@implementation MCAWolframAlphaOutputParser

static NSString * const MCAWolframXMLPodKey = @"pod";
static NSString * const MCAWolframXMLPodTitleAttributeKey = @"title";
static NSString * const MCAWolframXMLDataElementPlaintext = @"plaintext";

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        _XMLData = data;
        _pods = [NSMutableArray array];
    }
    
    return self;
}

- (void)parseWithCompletion:(OutputCompletion)completion {
    self.parser = [[NSXMLParser alloc] initWithData:self.XMLData];
    self.completion = completion;
    self.parser.delegate = self;
    BOOL success = [self.parser parse];
    if (success == NO) {
        if (self.completion) {
            self.completion(nil, [NSError errorWithDomain:NSXMLParserErrorDomain code:NSXMLParserEmptyDocumentError userInfo:nil]);
        }
    }
}

- (void)dealloc {
    
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:MCAWolframXMLPodKey]) {
        if (self.podData.count > 0) {
            MCAWolframAlphaSectionData *sectionData = [[MCAWolframAlphaSectionData alloc] initWithData:self.podData
                                                                                                 title:self.podTitle];
            [self.pods addObject:sectionData];
        }
        self.podData = [NSMutableArray array];
        self.podTitle = attributeDict[MCAWolframXMLPodTitleAttributeKey];
    } else if ([elementName isEqualToString:MCAWolframXMLDataElementPlaintext]) {
        self.parseFoundString = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.parseFoundString) {
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (trimmedString.length > 0) {
            [self.podData addObject:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName {
    self.parseFoundString = NO;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        OutputCompletion completion = self.completion;
        self.completion = nil;
        completion(self.pods, nil);
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        OutputCompletion completion = self.completion;
        self.completion = nil;
        completion(nil, parseError);
    }
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    if (self.completion) {
        OutputCompletion completion = self.completion;
        self.completion = nil;
        completion(nil, validationError);
    }
}

@end
