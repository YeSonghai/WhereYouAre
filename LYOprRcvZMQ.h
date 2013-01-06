//
//  LYOprRcvZMQ.h
//  RTTGUIDE
//
//  Created by Ye Sean on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tss.pb.h"
#import "ZMQSocket.h"
#import "ZMQContext.h"
#import "LYCommDelegate.h"

@interface LYOprRcvZMQ : NSOperation
{
    ZMQContext *zmqTSSContext;
    ZMQSocket *zmqTSSSocket;
    __unsafe_unretained NSObject <LYCommDelegate> *delegate;
}

@property (nonatomic, strong) ZMQContext* zmqTSSContx;
@property (nonatomic, strong) ZMQSocket* zmqTSSSocket;

//接收到数据后回调的Delegate
@property (nonatomic, assign) NSObject <LYCommDelegate> *delegate;

- (id) initWithZMQ:(ZMQContext*) zmqctx andSocket:(ZMQSocket*)zmqsocket;

@end
