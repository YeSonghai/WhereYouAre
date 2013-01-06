//
//  LYOprRcvZMQ.m
//  RTTGUIDE
//
//  Created by Ye Sean on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//#import "RttGViewController.h"
#import "LYOprRcvZMQ.h"

@implementation LYOprRcvZMQ


@synthesize zmqTSSContx;
@synthesize zmqTSSSocket;
@synthesize delegate;

- (id) initWithZMQ:(ZMQContext*) zmqctx andSocket:(ZMQSocket*)zmqsocket
{
    self = [super init];
    self.zmqTSSContx = zmqctx;
    self.zmqTSSSocket = zmqsocket;
    
    return self;
}

- (void)main 
{ 
    
    @autoreleasepool
    {
        while (true)
        {
            
            NSData *reply = [[zmqTSSSocket receiveDataWithFlags:0] copy];
            
            if (reply != nil)
            {
                [self.delegate performSelectorOnMainThread:@selector(OnRceivePacket:) withObject:(NSData*)reply waitUntilDone:0];
            }
        }
    }
    
} 

@end
