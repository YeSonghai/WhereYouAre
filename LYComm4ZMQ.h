//
//  LYComm4ZMQ.h
//  Easyway
//
//  Created by Ye Sean on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCommDelegate.h"
#import "ZMQSocket.h"

@class ZMQContext;
@class ZMQSocket;


@interface LYComm4ZMQ : NSObject
{
    ZMQContext *zmqTSSContext;
    ZMQSocket *zmqTSSSocket;
    
    NSOperationQueue *rttThreadQue; 
}

//- (id) initWithEndpoint:(NSString*) endpoint delegate:(NSObject <LYCommDelegate> *) delegate;
- (id) initWithEndpoint:(NSString*) endpoint uuID:(NSString*)uuID delegate:(NSObject <LYCommDelegate> *) delegate;
- (BOOL)sendData:(NSData *)messageData withFlags:(ZMQMessageSendFlags)flags;

- (id) Reset:(NSString*) endpoint uuID:(NSString*)uuID delegate:(NSObject <LYCommDelegate> *) delegate;


@end
