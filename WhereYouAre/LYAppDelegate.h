//
//  LYAppDelegate.h
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-4.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYViewController;
@class BMKMapManager;

@interface LYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LYViewController *viewController;

@property BMKMapManager* baiduMapManager;
@end
