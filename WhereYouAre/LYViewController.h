//
//  LYViewController.h
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-4.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//


#import <UIKit/UIKit.h>

@class LYTopBarView;
@class Reachability;
@class LYMapView;

@interface LYViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIView *topBarView;

@property LYTopBarView *mainTopBarView;
@property LYMapView *mainMapView;

@property Reachability *internetReachable;
@property BOOL internetActive;
@property Reachability *hostReachable;
@property BOOL hostActive;

- (void) initMainTopbar;
- (void) showMainTopbar;
- (void) hideMainTopbar;


@end
