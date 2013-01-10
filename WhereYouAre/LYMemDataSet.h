//
//  LYMemDataSet.h
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-9.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYLocationInfo;

@interface LYMemDataSet : NSObject

@property LYLocationInfo *FriendLocation;
@property LYLocationInfo *MeetingPointLocation;
@property NSString *CityName;
@property NSString *TrackingWebSession;


@end
