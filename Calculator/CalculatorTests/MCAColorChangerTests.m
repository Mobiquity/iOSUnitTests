//
//  MCAColorChangerTests.m
//  Calculator
//
//  Created by Chris Nielubowicz on 8/5/16.
//  Copyright © 2016 Mobiquity, Inc. All rights reserved.
//

#import "MCABaseTestCase.h"
#import "MCAColorChanger.h"

@interface MCAColorChanger ()
- (void)setChangeColors:(BOOL)changeColors;
@end

@interface MCAColorChangerTests : MCABaseTestCase

@end

@implementation MCAColorChangerTests

- (void)testToggleStateTrue {
    MCAColorChanger *changer = [[MCAColorChanger alloc] init];
    XCTAssertFalse(changer.changeColors);
    [changer setChangeColors:YES];
    XCTAssertTrue(changer.changeColors);
    XCTAssertEqualObjects([changer currentColor], [changer onColor]);

}

- (void)testToggleStateFalse {
    MCAColorChanger *changer = [[MCAColorChanger alloc] init];
    XCTAssertTrue(changer.changeColors);
    [changer setChangeColors:NO];
    XCTAssertFalse(changer.changeColors);
    XCTAssertEqualObjects([changer currentColor], [changer offColor]);
}

@end
