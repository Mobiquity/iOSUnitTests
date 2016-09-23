//
//  MCAWolframAlphaQuery.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/3/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAWolframAlphaQuery.h"

NSString * const wolframAlphaQueryString = @"http://api.wolframalpha.com/v2/query?input=%@&appid=%@&format=plaintext";

@interface MCAWolframAlphaQuery()

@property (nonatomic, copy) NSString *query;

@end

@implementation MCAWolframAlphaQuery

- (instancetype)init {
    return [self initWithQueryText:nil];
}

- (instancetype)initWithQueryText:(NSString *)query {
    if (query == nil || query.length == 0) {
        return nil;
    }
    
    if (self = [super init]) {
        NSMutableCharacterSet *URLQueryPartAllowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [URLQueryPartAllowedCharacterSet removeCharactersInString:@"#$&+,/:;=?@[]"]; // escape all characters WolframAlpha API does not accept in query
        _query = [query stringByAddingPercentEncodingWithAllowedCharacters:URLQueryPartAllowedCharacterSet];
    }
    return self;
}

- (NSURL *)queryURL {
    NSString *appID = @"7455XJ-6VH386Y4Y4";
    NSString *urlString = [NSString stringWithFormat:wolframAlphaQueryString, self.query, appID];
    NSURL *queryURL = [NSURL URLWithString:urlString];
    return queryURL;
}

@end
