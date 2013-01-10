//
//  LYViewController.h
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-4.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "bmapkit.h"
#import "LYVCDelegate.h"


@class LYTopBarView;
@class Reachability;
@class LYMapView;
@class LYSearchBarView;
@class LYSuggestionListViewController;

@interface LYViewController : UIViewController <MFMessageComposeViewControllerDelegate, LYVCDelegate, BMKMapViewDelegate, BMKSearchDelegate>
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIView *topBarView;

@property (strong, nonatomic) BMKSearch  *mapSearcher;

@property LYTopBarView *mainTopBarView;
@property LYMapView *mainMapView;
@property LYSearchBarView *topSearchBar;
@property LYSuggestionListViewController *suggestionListVC;

@property Reachability *internetReachable;
@property BOOL internetActive;
@property Reachability *hostReachable;
@property BOOL hostActive;


@property UIButton *uiBTNSendSMS4GetLocation;
@property UIButton *uiBTN2GetMeetLocation;
@property UIButton *uiBTNGetHelpInfo;


- (void) initMainTopbar;
- (void) showMainTopbar;
- (void) hideMainTopbar;
-(void) initSearchBar;


- (void) diSendSMS4GetLocation;
- (void) diGetMeetLocation;
- (void) diShowHelpInfo;




@end
