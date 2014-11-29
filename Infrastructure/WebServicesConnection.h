//
//  WebServicesConnection.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebServicesConnection;

@protocol WebServicesDelegate <NSObject>

@optional
- (void)webServicesConnection:(WebServicesConnection *) webServicesConnection afterConnectedReturnString:(NSString *) resultStr;

@end

@interface WebServicesConnection : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    
}

@property (nonatomic,assign) id<WebServicesDelegate>    delegate;
@property (nonatomic,assign) int                        multilevel;
@property (nonatomic,retain) NSString                   *tempData;

- (BOOL)canConnect;

/**
 * 通过GET方式同步获取服务器数据
 */
- (NSString *)synchronizedGetFromURL:(NSURL *)url timeoutInterval:(NSUInteger)timeoutInterval ;

/**
 * 通过POST方式同步获取服务器数据
 */
- (NSString *)synchronizedPostJsonString:(NSString *)data toURL:(NSURL *)url timeoutInterval:(NSUInteger)timeoutInterval;

/* 通过GET方式提交数据到服务端
 * url : 带有get信息的url信息,直接发往服务器
 */
- (void)getFromURL:(NSURL *)url;

/* 通过POST方式发送json数据到服务端
 * data   : 发送的json数据
 * url    : 发送的url地址
 * isSync : 是否同步发送数据(同步发送会进行等待服务器响应)
 */
- (void)postData:(NSString *)data toURL:(NSURL *)url;

@end