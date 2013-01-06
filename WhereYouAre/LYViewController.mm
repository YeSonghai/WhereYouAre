//
//  LYViewController.m
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-4.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//

#import "LYViewController.h"
#import "LYTopBarView.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "bmapkit.h"
#import "LYMapView.h"

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initMapView];
    
    //[self initMainTopbar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setTopBarView:nil];
    [super viewDidUnload];
}


#pragma mark -
#pragma mark init UI 

- (void) initMapView
{
    self.mainMapView = [[LYMapView alloc]initWithFrame:self.mapView.frame];
    [self.mapView  addSubview:self.mainMapView];
    
}

- (void) initMainTopbar
{

    //self.mainTopBarView = [[[NSBundle mainBundle] loadNibNamed:@"LYTopBarView" owner:self options:nil] lastObject];
    [self.mainTopBarView = [UIView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,80.0)];
    //[self.mainTopBarView setFrame:CGRectMake(0.0,0.0,320.0,20.0)];
    [self.mainTopBarView setCenter:CGPointMake(160.0, 40.0)];
    [self.mainTopBarView setBackgroundColor:[UIColor lightGrayColor]];
    [[self view] addSubview:self.mainTopBarView];
    
//    //设置圆角
//    [self.mainTopBarView.layer setCornerRadius:12.0f];
    
    //设置阴影
    self.mainTopBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.mainTopBarView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移，垂直偏移]
    self.mainTopBarView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0的值
    self.mainTopBarView.layer.shadowRadius = 10.0f; // 阴影发散的程度
}

- (void) showMainTopbar
{
    [self.mainTopBarView setHidden:NO];
}

- (void) hideMainTopbar
{
    [self.mainTopBarView setHidden:YES];
}


#pragma mark -
#pragma mark Communication Functions
- (void) initCommUnit
{
    //初始化和启动通信模块
//    mTSSMessageSerialNum = 0; //消息序列号
//    
//    mComm4TSS = [[LYComm4ZMQ alloc] initWithEndpoint:@"tcp://roadclouding.com:6001" uuID:runningDataset.deviceUuid delegate:self];
}

- (void) resetCommUnit
{
//    [mComm4TSS Reset:@"tcp://roadclouding.com:6001" uuID:runningDataset.deviceUuid delegate:self];
}


- (BOOL) isNetworkActive
{
    BOOL isNetworkReachable = NO;
    Reachability *r = [Reachability reachabilityForInternetConnection];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            //NSLog(@"############# Not Reachable#######");
            break;
        case ReachableViaWWAN:
            // 使用3G网络
        {
            //NSLog(@"############# Use 3G #######");
            isNetworkReachable = YES;
        }
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
        {
            //NSLog(@"############# Use WiFi #######");
            isNetworkReachable = YES;
        }
            break;
    }
    return isNetworkReachable;
}

- (BOOL) isNetworkReachable
{
    BOOL isNetworkReachable = NO;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.roadclouding.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            //NSLog(@"############# Not Reachable#######");
            break;
        case ReachableViaWWAN:
            // 使用3G网络
        {
            //NSLog(@"############# Use 3G #######");
            isNetworkReachable = YES;
        }
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
        {
            //NSLog(@"############# Use WiFi #######");
            isNetworkReachable = YES;
        }
            break;
    }
    return isNetworkReachable;
}

- (BOOL) detectNetworkReachableAndShowTips
{
    
    BOOL isReachable = [self isNetworkReachable];
    if (!isReachable)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"当前网络无法连接到互联网\n请稍后再试"
                                                          delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alertView show];
    }
    return isReachable;
}


-(void)checkNetworkStatus:(NSNotification*)notice
{
    // called after network status changes
    NetworkStatus internetStatus =[self.internetReachable currentReachabilityStatus];
    switch(internetStatus)
    {
        case NotReachable:
        {
            //NSLog(@"The internet is down.");
            self.internetActive =NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"The internet is working via WIFI.");
            self.internetActive =YES;
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"The internet is working via WWAN.");
            self.internetActive =YES;
            break;
        }
    }
    
    
    NetworkStatus hostStatus = [self.hostReachable currentReachabilityStatus];
    switch(hostStatus)
    {
        case NotReachable:
        {
            //NSLog(@"A gateway to the host server is down.");
            self.hostActive =NO;
            break;
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive =YES;
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive =YES;
            break;
        }
    }
    
//    if (self.hostActive || self.internetActive)
//    {
//        //send something to server to keep ZMQ alive;
//    }
    
}

- (void) OnRceivePacket:(NSData*) rcvdata
{
    //NSLog(@"*********RECEIVED DATA******************");
    if (rcvdata == nil)
    {
        NSLog(@"invalid data");
        return;
    }
}






@end
