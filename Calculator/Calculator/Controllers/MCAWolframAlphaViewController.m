//
//  MCAWolframAlphaViewController.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/3/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAWolframAlphaViewController.h"
#import "MCAWolframAlphaQuery.h"
#import "MCAWolframAlphaOutputParser.h"
#import "MCAWolframAlphaDataSource.h"

@interface MCAWolframAlphaViewController ()

@property (weak, nonatomic) IBOutlet UITextField *wolframAlphaInput;
@property (weak, nonatomic) IBOutlet UITableView *wolframOutput;

@property (strong, nonatomic) MCAWolframAlphaDataSource *dataSource;
@property (strong, nonatomic) MCAWolframAlphaOutputParser *parser;

@end

@implementation MCAWolframAlphaViewController

- (IBAction)sendToWolfram:(id)sender {
    MCAWolframAlphaQuery *query = [[MCAWolframAlphaQuery alloc] initWithQueryText:self.wolframAlphaInput.text];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[query queryURL]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                self.parser = [[MCAWolframAlphaOutputParser alloc] initWithData:data];
                [self.parser parseWithCompletion:^(id content, NSError *error) {
                    self.dataSource = [[MCAWolframAlphaDataSource alloc] initWithWolframPods:content];
                    self.wolframOutput.dataSource = self.dataSource;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.wolframOutput reloadData];
                    });
                }];
            }] resume];
}

@end
