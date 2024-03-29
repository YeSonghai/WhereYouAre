//
//  LYComm4ZMQ.m
//  Easyway
//
//  Created by Ye Sean on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LYComm4ZMQ.h"
#import "ZMQSocket.h"
#import "ZMQContext.h"
#import "LYOprRcvZMQ.h"

@implementation LYComm4ZMQ


//初始化：endpoint: 连接的端点；delegate:实现OnRceivePacket方法的类实例
- (id) initWithEndpoint:(NSString*) endpoint uuID:(NSString*)uuID delegate:(NSObject <LYCommDelegate> *) delegate
{
    //初始化和启动通信模块
    zmqTSSContext = [[ZMQContext alloc] initWithIOThreads:1U];
    //static NSString *const kEndpoint = endpoint;//@"tcp://42.121.18.140:6001";
    //NSLog(@"*** Start to connect to endpoint [%@].", endpoint);
    zmqTSSSocket = [zmqTSSContext socketWithType:ZMQ_DEALER];
    
    NSData* uuIDData=[uuID dataUsingEncoding: [NSString defaultCStringEncoding] ];
    //[zmqTSSSocket setData:uuIDData forOption:ZMQ_IDENTITY];
    //NSLog(@"Device UUID=%@", uuID);
        
    BOOL didBind = [zmqTSSSocket connectToEndpoint:endpoint];
    if (!didBind) 
    {
        NSLog(@"*** Failed to connect to endpoint [%@].", endpoint);
        return nil;
    }
    else 
    {
        NSLog(@"*** Successed to connected to endpoint [%@].", endpoint);
    }
    
    LYOprRcvZMQ *pRcvThread = [[LYOprRcvZMQ alloc] initWithZMQ:zmqTSSContext andSocket:zmqTSSSocket];
    rttThreadQue = [[NSOperationQueue alloc] init];
    [pRcvThread setDelegate:delegate]; 
    
    [rttThreadQue addOperation:pRcvThread];
    
    return self;
}

//发送，直接调用ZMQ的发送函数
- (BOOL)sendData:(NSData *)messageData withFlags:(ZMQMessageSendFlags)flags
{
    return [zmqTSSSocket sendData:messageData withFlags:0]; 
}

//接收，delegate实现LYCommDelegate协议的OnRceivePacket方法



//初始化：endpoint: 连接的端点；delegate:实现OnRceivePacket方法的类实例
- (id) Reset:(NSString*) endpoint uuID:(NSString*)uuID delegate:(NSObject <LYCommDelegate> *) delegate
{
    [rttThreadQue cancelAllOperations];
    [zmqTSSContext terminate];
    zmqTSSContext = nil;
    
    
    //初始化和启动通信模块
    zmqTSSContext = [[ZMQContext alloc] initWithIOThreads:1U];
    //static NSString *const kEndpoint = endpoint;//@"tcp://42.121.18.140:6001";
    //NSLog(@"*** Start to connect to endpoint [%@].", endpoint);
    zmqTSSSocket = [zmqTSSContext socketWithType:ZMQ_DEALER];
    
    NSData* uuIDData=[uuID dataUsingEncoding: [NSString defaultCStringEncoding] ];
    [zmqTSSSocket setData:uuIDData forOption:ZMQ_IDENTITY];
    //NSLog(@"Device UUID=%@", uuID);
    
    BOOL didBind = [zmqTSSSocket connectToEndpoint:endpoint];
    if (!didBind)
    {
        //NSLog(@"*** Failed to connect to endpoint [%@].", endpoint);
        return nil;
    }
    else
    {
        //NSLog(@"*** Successed to connected to endpoint [%@].", endpoint);
    }
    
    LYOprRcvZMQ *pRcvThread = [[LYOprRcvZMQ alloc] initWithZMQ:zmqTSSContext andSocket:zmqTSSSocket];
    rttThreadQue = [[NSOperationQueue alloc] init];
    [pRcvThread setDelegate:delegate];
    
    [rttThreadQue addOperation:pRcvThread];
    
    return self;
}

@end
