//
//  ZhiMengPointsManger.h
//  MobsmarSDK
//
//  Created by wisdome on 14-5-4.
//  Copyright (c) 2014年 wisdome. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 虚拟币更新的通知，用户需要通过注册这个通知，当虚拟币的数目改变时,该通知都会被调用，该通知只是获取当前虚拟币的数目，并不会消费，用户可通过spendPoints: 接口花费积分
 
 获取方式：
 1.  注册通知
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(getUpdatedPoints:)
 ZHIMENG_UPDATASUCCESS_POINT
 object:nil];
 2.  实现该通知的方法
 - (void)getUpdatedPoints:(NSNotification *)noti
 {
 用户获取的积分在指盟后台可设置为小数,如果设置为小数，用户需要转化为double类型
 [[[noti valueForKey:@"object"]valueForKey:@"point"]doubleValue];来使用积分
 如果设置为整数，用户转化为int类型来使用
 [[[noti valueForKey:@"object"]valueForKey:@"point"]intValue];
 NSLog(@"金币==%@",[[noti valueForKey:@"object"] valueForKey:@"point"]);
 }
 */
#define ZHIMENG_UPDATASUCCESS_POINT     @"UPDATASUCCESS"

//获取虚拟币积分失败
#define ZHIMENG_UPDATAFAILED_POINT      @"UPDATAFAILED"
//花费积分成功
#define ZHIMENG_SPENDSUCCESS_POINT      @"SPESUCCESS"

//赚取积分成功
#define ZHIMENG_AWARDSUCCESS_POINT      @"AWASUCCESS"

@interface ZhiMengPointsManger : NSObject

/*
 //初始化积分墙,此方法务必在AppDelegate中的- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法中实现
 */
+ (ZhiMengPointsManger *)enable;
/*
 查询当前积分，查询出来的虚拟币数目，查询结果用户需要注册 ZHIMENG_UPDATASUCCESS_POINT 通知，在通知方法里面获取积分的数目
 */
+ (void)getPoints;
/*
 //消耗指定积分,此方法是用户消耗积分的方法，points参数即为消耗的积分，消耗了多少积分，相应扣除用户多少积分.
 */
+ (void)spendPoints:(double)points;
/*
 //赚取指定积分,此方法是用户赚取积分的方式，points参数即为赚取的积分，赚取了多少积分，相应用户增加多少积分.
 */
+ (void)awardPoints:(double)points;
@end
