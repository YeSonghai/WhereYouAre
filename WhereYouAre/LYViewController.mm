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
#import "LYHelpInfoViewController.h"
#import "LYSearchBarView.h"
#import "LYSuggestionListViewController.h"



@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initMapView];
    
    [self initMainTopbar];
    [self initSearchBar];
    
    //设置搜索建议结果列表框
    [self initSuggestionListView];
    [self.view addSubview:self.suggestionListVC.view];
    
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
    CGRect mainScreenRect = [[UIScreen mainScreen] bounds];
    self.mainMapView = [[LYMapView alloc]initWithFrame:mainScreenRect];
    [self.mapView  addSubview:self.mainMapView];
    
    if (!(self.mapSearcher))
    {
        self.mapSearcher = [[BMKSearch alloc]init];
        [self.mapSearcher setDelegate:self];
    }
    
}

- (void) initMainTopbar
{
    self.mainTopBarView = [[[NSBundle mainBundle] loadNibNamed:@"LYTopBarView" owner:self options:nil] lastObject];
    //[self.mainTopBarView = [UIView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,80.0)];
    [self.mainTopBarView setFrame:CGRectMake(0.0,0.0,320.0,80.0)];
    [self.mainTopBarView setCenter:CGPointMake(160.0, 40.0)];
    [self.mainTopBarView setBackgroundColor:[UIColor lightGrayColor]];
    [[self view] addSubview:self.mainTopBarView];
    
    self.mainTopBarView.delegate = self;
    
    
//    //设置圆角
//    [self.mainTopBarView.layer setCornerRadius:6.0f];
    
//    //设置阴影
//    self.mainTopBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.mainTopBarView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移，垂直偏移]
//    self.mainTopBarView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0的值
//    self.mainTopBarView.layer.shadowRadius = 10.0f; // 阴影发散的程度
    
//    self.uiBTNSendSMS4GetLocation = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.uiBTNSendSMS4GetLocation.frame = CGRectMake(10.0, 10.0, 60, 60);
//    [self.uiBTNSendSMS4GetLocation addTarget:self action:@selector(diSendSMS4GetLocation) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *uiImgTmp1 = [UIImage imageNamed:@"TopButtom.png"];
//    [self.uiBTNSendSMS4GetLocation setImage:uiImgTmp1 forState:UIControlStateNormal];
//    
//    
//    self.uiBTN2GetMeetLocation = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.uiBTN2GetMeetLocation.frame = CGRectMake(130.0, 10.0, 60, 60);
//    [self.uiBTN2GetMeetLocation addTarget:self action:@selector(diGetMeetLocation) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *uiImgTmp2 = [UIImage imageNamed:@"TopButtom.png"];
//    [self.uiBTN2GetMeetLocation setImage:uiImgTmp2 forState:UIControlStateNormal];
//
//    self.uiBTNGetHelpInfo = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.uiBTNGetHelpInfo.frame = CGRectMake(250.0, 10.0, 60, 60);
//    [self.uiBTNGetHelpInfo addTarget:self action:@selector(diShowHelpInfo) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *uiImgTmp3 = [UIImage imageNamed:@"TopButtom.png"];
//    [self.uiBTNGetHelpInfo setImage:uiImgTmp3 forState:UIControlStateNormal];
//
//    [self.mainTopBarView addSubview:self.uiBTNSendSMS4GetLocation];
//    [self.mainTopBarView addSubview:self.uiBTN2GetMeetLocation];
//    [self.mainTopBarView addSubview:self.uiBTNGetHelpInfo];

}

- (void) showMainTopbar
{
    [self.mainTopBarView setHidden:NO];
}

- (void) hideMainTopbar
{
    [self.mainTopBarView setHidden:YES];
}



-(void) initSearchBar
{
    
    self.topSearchBar = [[[NSBundle mainBundle] loadNibNamed:@"LYSearchBar" owner:self options:nil] lastObject];
    [self.topSearchBar setCenter:CGPointMake(160.0, 20.0)];
    [self.topSearchBar setInputDelegate];
    [self.topSearchBar setDelegate:self];
    
    [[self view] addSubview:self.topSearchBar];
    
    //设置圆角
    //[mTrafficInfoBoard.layer setCornerRadius:12.0f];
    
    //设置阴影
    self.topSearchBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.topSearchBar.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移，垂直偏移]
    self.topSearchBar.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0的值
    self.topSearchBar.layer.shadowRadius = 10.0f; // 阴影发散的程度
    
    [self.topSearchBar setHidden:YES];
}

- (void) hideTopSearchBar
{
    [self.topSearchBar dismissKeyboard];
    [self.topSearchBar setHidden:YES];
    
    [self setSearchListHidden:YES];
    [self showMainTopbar];
}

- (void) showTopSearchBar
{
    [self.topSearchBar.uiInputTxtField setText:@""];
    [self.topSearchBar setHidden:NO];
    [self hideMainTopbar];
}

- (void) initSuggestionListView
{
    self.suggestionListVC = [[LYSuggestionListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.suggestionListVC.delegate = self;
    [self.suggestionListVC.view setFrame:CGRectMake(5, 42, 0, 0)];
}

- (void)setSearchListHidden:(BOOL)hidden
{
    if (!hidden)
    {
        [self.suggestionListVC.view setHidden:NO];
    }
	NSInteger height = hidden ? 0 : 125; //180
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
	//[mSuggestionListVC.view setFrame:CGRectMake(mSuggestionListVC.view.frame.origin.x, mSuggestionListVC.view.frame.origin.y, 210, height)];
    [self.suggestionListVC.view setFrame:CGRectMake(self.suggestionListVC.view.frame.origin.x, self.suggestionListVC.view.frame.origin.y, 310, height)];
	[UIView commitAnimations];
    
    
    if (hidden)
    {
        [self.suggestionListVC clearData];
        [self.suggestionListVC updateData];
        [self.suggestionListVC.view setHidden:YES];
    }
}




#pragma mark -
#pragma mark UI Actions

//- (void)diSendSMS4GetLocation:(id)sender;
//- (void)diGetMeetLocation:(id)sender;
//- (void)diShowHelpInfo:(id)sender;

- (void) diSendSMS4GetLocation:(id)sender
{
    [self sendSMS:@"需要获得您的位置信息，如果您同意，请点击下面的链接：" recipientList:nil];
}

- (void) diGetMeetLocation:(id)sender
{
//    [self hideMainTopbar];
//    [self.topSearchBar setHidden:NO];
    [self showTopSearchBar];
}

- (void) diShowHelpInfo:(id)sender
{
    LYHelpInfoViewController *helpView = [[LYHelpInfoViewController alloc] init];
    [self.navigationController pushViewController:helpView animated:YES];
}


#pragma mark -
#pragma mark SMS Functions

//内容，收件人列表
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    
    if([MFMessageComposeViewController canSendText])
    {
        
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        [self presentModalViewController:controller animated:YES];
        
    }
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
    }
    else
    {
        if (result == MessageComposeResultSent)
        {
            NSLog(@"Message sent");
        }
        else
        {
            NSLog(@"Message failed");
        }
    }
}



#pragma mark -
#pragma mark Searchbar delegate

- (void)didAddrSearchWasPressed:(NSString*)inputStr
{
    NSString *strPOIName = inputStr;
    //[self.mapSearcher poiSearchInCity:@"深圳" withKey:strPOIName pageIndex:0];
    
    if (![self detectNetworkReachableAndShowTips])
    {
        return;
    }
    
    BOOL result = [self getPoiLocationInCityfromMAPSVR:@"深圳" poiName:strPOIName];
    if (!result)
    {
        
        //NSLog(@"Failure when get poi location from map server");
        //百度已经有提示了，所以不用重复提示
        //            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:errorMsg
        //                                                              delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        //            [alertView show];
        return;
    }
    else
    {
        //[self hideTopSearchBar];
        [self didHideAddrSearchBar:nil];
        
//        [self setRunningActivityTimer:10 activity:RTTEN_ACTIVITYTYPE_GETTINGGEO];
//        [self showModeIndicator:@"获取地理坐标信息" seconds:10];
    }
    
}
- (void)didAddrSearchInputWasChanged:(NSString*)inputStr
{
    if ([inputStr length] != 0)
    {
        if (![self isNetworkReachable])
        {
            return;
        }
        
        BOOL callresult = [self getPoinameSuggestionfromMAPSVR:inputStr];
        if (!callresult)
        {
            //NSLog(@"######Call sugession Error");
        }
        
        self.suggestionListVC.searchText = inputStr;
        [self.suggestionListVC updateData];
        [self setSearchListHidden:NO];
    }
    else
    {
        [self setSearchListHidden:YES];
    }
    
}
- (void)didAddrSearchBegin:(id)sender
{
    [self.suggestionListVC clearData];
    
//    if (runningDataset.searchHistoryArray.count > 0)
//    {
//        for (NSString *searchHisTxt in runningDataset.searchHistoryArray)
//        {
//            //NSLog(@"**********Input TXT=%@************", searchHisTxt);
//            [mSuggestionListVC.resultList addObject:searchHisTxt];
//        }
//        [suggestionListVC updateData];
//        [self setSearchListHidden:NO];
//    }
    
}


- (void)didResultlistSelected:(NSString *)poiName
{
	if (poiName)
    {
        [self didAddrSearchWasPressed:poiName];
        //[runningDataset saveSearchHistory:poiName];
	}
    [self setSearchListHidden:YES];
    
    //[self hideTopSearchBar];
    [self didHideAddrSearchBar:nil];
}

- (void)didHideAddrSearchBar:(id)sender
{
    [self hideTopSearchBar];
}


#pragma mark -
#pragma mark Process Request to MAP Service

- (BOOL) getPoinameSuggestionfromMAPSVR:(NSString*)searchStr
{
    BOOL callresult = [self.mapSearcher suggestionSearch:searchStr];
    return callresult;
}

//获取POI描述信息对应的地理坐标
- (BOOL) getPoiLocationInCityfromMAPSVR:(NSString*)cityName poiName:poiName
{
    return [self.mapSearcher poiSearchInCity:cityName withKey:poiName pageIndex:0];
}

//获取地理坐标对应的POI描述信息
- (BOOL) getGeoInfofromMAPSVR:(CLLocationCoordinate2D)coordinate
{
    //因为百度API是异步通过网络返回坐标POI信息，并且没有消息元素区分，所以多个点加入的时间比较短的话有可能会有错误（待处理）
    
//    if (!(self.mapSearcher))
//    {
//        self.mapSearcher = [[BMKSearch alloc]init];
//    }
    
    bool result = [self.mapSearcher reverseGeocode:coordinate];
    if (!result)
    {
        //NSLog(@"***设置导航点，获取当前地址错误***");
    }
    
    //[self showModeIndicator:@"正在获取位置信息" seconds:0];
    
    return result;
}

#pragma mark -
#pragma mark Baidu Delegate Event Process
- (void)onGetSuggestionResult:(BMKSuggestionResult*)result errorCode:(int)error
{
    if (error != BMKErrorOk)
    {
        //NSLog(@"######get sugession Error, errorcode:%d", error);
        //        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"无法获得输入建议"
        //                                                          delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        //        [alertView show];
        return;
    }
    
    //poiSuggestionList = result.keyList;
    [self.suggestionListVC.resultList removeAllObjects];
    
    for (int i = 0; i < result.keyList.count; i++)
    {
        NSString *strPoiName = [result.keyList objectAtIndex:i];
        //NSLog(@"POISuggestion: %@", strPoiName);
        
        [self.suggestionListVC.resultList addObject:strPoiName];
        //[mSuggestionListVC updateData];
    }
    [self.suggestionListVC updateData];
}


//得到Poi的地理位置坐标信息
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    
	if (error == BMKErrorOk)
    {
		BMKPoiResult* result = (BMKPoiResult*) [poiResultList objectAtIndex:0];
        
        if (result.poiInfoList.count > 0)
        {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:0];
            
            BMKPoiInfo *firstPoi = [result.poiInfoList objectAtIndex:0];
            NSString *pointAddr = firstPoi.address;
            NSString *pointName = firstPoi.name;
            NSString *addrTxt = [[NSString alloc] initWithFormat:@"%@\r\n%@", pointAddr, pointName ];
            
            [self.mainMapView removeAllUndefAnnotation];
            [self.mainMapView addAnnotation2Map:poi.pt withType:MAPPOINTTYPE_UNDEF addr:addrTxt];
            
            [self.mainMapView setCenterOfMapView:poi.pt];
        }
	}
    else
    {
        //NSLog(@"POI Search Fail, Error Code=%d", error);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"无法获取检索结果"
                                                          delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alertView show];
    }
}


//获取地理位置的路名地址等POI信息
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{    
	if (error != BMKErrorOk)
    {
    	//NSLog(@"onGetDrivingRouteResult:error:%d", error);
        return;
    }
    
    //[self.mapView setWaitingPOIAnnotationAddress:result];
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
