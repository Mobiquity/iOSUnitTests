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

@property (nonatomic, retain) MCAColorChanger *changer;
@property (nonatomic, assign) BOOL previousState;

@end

@implementation MCAColorChangerTests

- (void)setUp {
    [super setUp];
    self.changer = [[MCAColorChanger alloc] init];
    self.previousState = self.changer.changeColors;
}

- (void)tearDown {
    // Ensure that we don't change our setting from the original!
    [self.changer setChangeColors:self.previousState];
    XCTAssertEqual(self.previousState, self.changer.changeColors);
    [super tearDown];
}

- (void)testToggleStateTrue {
    [self.changer setChangeColors:YES];
    XCTAssertTrue(self.changer.changeColors);
    XCTAssertEqualObjects([self.changer currentColor], [self.changer onColor]);

}

- (void)testToggleStateFalse {
    [self.changer setChangeColors:NO];
    XCTAssertFalse(self.changer.changeColors);
    XCTAssertEqualObjects([self.changer currentColor], [self.changer offColor]);
}

@end
