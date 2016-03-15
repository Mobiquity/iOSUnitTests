//
//  MCAWolframAlphaDataSource.m
//  Calculator
//
//  Created by Chris Nielubowicz on 3/13/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCAWolframAlphaDataSource.h"
#import "MCAWolframAlphaTableViewCell.h"
#import "MCAWolframAlphaSectionData.h"

@interface MCAWolframAlphaDataSource()

@property (copy, nonatomic) NSArray<MCAWolframAlphaSectionData *> *podData;

@end

@implementation MCAWolframAlphaDataSource

- (instancetype)initWithWolframPods:(NSArray<MCAWolframAlphaSectionData *> *)pods {
    if (self = [super init]) {
        _podData = pods;
    }
    return self;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.podData.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MCAWolframAlphaSectionData *sectionData = self.podData[section];
    return sectionData.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MCAWolframAlphaSectionData *sectionData = self.podData[section];
    return sectionData.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellReuseIdentifier = @"wolfram";
    MCAWolframAlphaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.wolframDataLabel.text = [self dataForIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Helpers

- (NSString *)dataForIndexPath:(NSIndexPath *)indexPath {
    MCAWolframAlphaSectionData *sectionData = self.podData[indexPath.section];
    NSString *data = sectionData.data[indexPath.row];
    return data;
}

@end
