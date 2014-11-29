//
//  ZhiMengAdconfig.h
//  ZhiMengAdconfig
//
//  Created by zhimeng on 14-4-15.
//  Copyright (c) 2014年 zhimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 获取后台开关
 在程序初始化的时候 用户只需注册该通知
 如：
 [[NSNotificationCenter defaultCenter]addObserver:self
 selector:@selector(configSuccess:)
 name:MCJ_CONFIGPARAM_SUCCESS
 object:nil];
 实现：
 - (void)configSuccess:(NSNotification *)noti
 {
 NSString *config = [[noti valueForKey:@"object"] valueForKey:@"configParam"];
 
 }
 */
#define MCJ_CONFIGPARAM_SUCCESS @"MCJ_CONFIGPARAM_SUCCESS"
/*
 获取开关失败的通知
 */
#define MCJ_CONFIGPARAM_FAILED   @"MCJ_CONFIGPARAM_FAILED"

@interface ZhiMengAdconfig : NSObject

/*
 appID：
 指盟appId的初始化，用户在指盟后台申请的appid
 
 userid：
 开发者设置服务器对接时,开发者设置的用户自定义参数
 */

+ (ZhiMengAdconfig*)requestZhiMengConnect:(NSString*)appID userId:(NSString*)userid;
/*
 不选择服务器对接可不设置 userid
 */
+ (ZhiMengAdconfig*)requestZhiMengConnect:(NSString*)appID;
/*
 获取状态开关(积分墙开关结果会在MCJ_CONFIGPARAM_SUCCESS和MCJ_CONFIGPARAM_FAILED通知的方法里回调结果)
 
 sdk启动时会相应回调一次通知，如果获取失败，开发者可选择再次获取
 */
- (void)zmOnlineKey;

+ (ZhiMengAdconfig*)sharedZhiMengConnect;

+ (NSString*)getAppID;
+ (NSString*)getUserid;
+ (NSString*)getVersion;

- (NSString*)isJailBrokenStr;
+ (NSString*)getMACID;

+ (NSString*)getAdvertiserIdentifier;
+ (NSString*)getOpenudid;
+ (NSString*)getNetWork;
+ (NSString *)getIntifier;


+ (BOOL) getConnection;
@end
