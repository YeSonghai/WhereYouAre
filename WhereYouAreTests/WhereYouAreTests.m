//
//  WhereYouAreTests.m
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-7.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//

#import "WhereYouAreTests.h"

@implementation WhereYouAreTests
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.mMainVC = [[LYViewController alloc] initWithNibName:@"LYViewController" bundle:nil];
    //LYViewController *mmt =
    
    STAssertNotNil(self.mMainVC, @"Main View Controller Init fall");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMainVC
{
    //STFail(@"Unit tests are not implemented yet in WhereYouAreTests");
    STAssertNotNil(self.mMainVC, @"MapView Init fall");
    
}


- (void) testInitMainTopbar
{
    [self.mMainVC initMainTopbar];
    STAssertNil(self.mMainVC.mainTopBarView, @"mainTopBarView Init fall");
}


@end
