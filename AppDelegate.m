//
//  AppDelegate.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//#import "TaskViewController.h"
//#import "MemberViewController.h"
//#import "ExchangeViewController.h"
//#import "SystemViewController.h"
//#import "ViewController.h"
//#import "LogonViewController.h"
#import "Reachability.h"
#import "DataShare.h"
#import "DataEntity.h"
#import "AppConfig.h"
#import "ThridSDK.h"
#import "UserPointManager.h"
#import "ZhiMengWallManagerImp.h"
#import "Utility.h"

@interface AppDelegate () {
    Reachability            *hostReach;
}

@end

@implementation AppDelegate

- (void)toLoginCtr
{
    LogonViewController *rootCtr = [[LogonViewController alloc] init];
    self.window.rootViewController = rootCtr;
}

- (void)toMainCtr
{
    self.window.rootViewController = [ViewController RootViewController];
}

- (void)reachabilityChanged:(NSNotification*)note{
    Reachability *curReach= [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status= [curReach currentReachabilityStatus];
    if(status == NotReachable) {
        
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //setenv("LOG_CURL", "YES", 0);
    [AVOSCloud setApplicationId:AppID clientKey:AppKey];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Register Remote Push
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    // [YouMiConfig setShouldGetLocation:NO];
    // 替换下面的appID和appSecret为你的appid和appSecret
    [YouMiConfig launchWithAppID:YouMiAppID appSecret:YouMiAppSecret];
    // 开启积分管理[本例子使用自动管理];
    [YouMiPointsManager enable];
    // 开启积分墙
    [YouMiWall enable];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 设置显示积分墙的全屏UIWindow
    [YouMiConfig setFullScreenWindow:self.window];
    
    [DataEntity registerSubClass];
    [AWUser localInfoDefault];

    if ([AVUser currentUser]) {
        [self toMainCtr];
    }
    else
    {
        [self toLoginCtr];
    }
    
    //LogonViewController *rootCtr = [[LogonViewController alloc] init];
    //[self.window setRootViewController:[ViewController RootViewController]];
    
    //监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)                                          name:kReachabilityChangedNotification object: nil];
    hostReach = [[Reachability reachabilityWithHostname:@"www.baidu.com"] retain];
    [hostReach startNotifier];
    
    //易积分
    [YJFUserMessage shareInstance].yjfUserAppId = EscoreAppID;
    [YJFUserMessage shareInstance].yjfUserDevId = EscoreDevID;
    [YJFUserMessage shareInstance].yjfAppKey = EscoreAppKey;
    [YJFUserMessage shareInstance].yjfChannel = EscoreChannel;
    //初始化
    YJFInitServer *InitData  = [[YJFInitServer alloc] init];
    [InitData  getInitEscoreData];
    [InitData  release];
    
    [JJSDK requestJJSession:JJSessionID withUserID:JJUserID];
    
    // !!!: Miidi SDK 初始化
    // 设置发布应用的应用id, 应用密码信息,必须在应用启动的时候呼叫
    // 参数 appID		:开发者应用ID ;     开发者到 www.miidi.net 上提交应用时候,获取id和密码
    // 参数 appPassword	:开发者的安全密钥 ;  开发者到 www.miidi.net 上提交应用时候,获取id和密码
    [MyOfferAPI setMiidiAppPublisher:MiidiAppID  withMiidiAppSecret:MiidiAppSecret];
    // 开发者自定义参数， 可以传开发者的User_id
    //[MyOfferAPI setUserParam:<#开发者参数_可以是UserID#>];
    
    /*
     param1:applicationKey param2:开启本地定位 param3:userid
     */
    //DR_INIT(DianRuAppKey, NO, nil)
    
    //[ZhiMengAdconfig requestZhiMengConnect:ZhiMengAppKey];
    //[ZhiMengPointsManger enable];
    
    /*
     //查询积分成功的通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataSuccess:) name:ZHIMENG_UPDATASUCCESS_POINT object:nil];
    /*
     *花费积分成功通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(spendSuccess:) name:ZHIMENG_SPENDSUCCESS_POINT object:nil];
    
    /*
     *赚取积分成功的通知
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(awardSuccess:) name:ZHIMENG_AWARDSUCCESS_POINT object:nil];
    /*
     *查询 花费 赚取积分失败都相应会在该通知里面回调
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataFailed:) name:ZHIMENG_UPDATAFAILED_POINT object:nil];
    
    /*
     获取积分墙开关配置的通知
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configSuccess:) name:MCJ_CONFIGPARAM_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configFailed:) name:MCJ_CONFIGPARAM_FAILED object:nil];

    return YES;
}

#pragma mark - ZhiMeng Delegate
- (void)updataSuccess:(NSNotification *)noti
{
    NSLog(@"+++=");
    int point = [[[noti valueForKey:@"object"] valueForKey:@"point"] intValue];
    NSLog(@"当前积分是: %d",point);
    
//    NSString *str = [NSString stringWithFormat:@"您当前积分是:%d",point];
//    self.viewController.point.text = str;
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
}
- (void)spendSuccess:(NSNotification *)noti
{
    int point = [[[noti valueForKey:@"object"] valueForKey:@"point"] intValue];
    
    if (point > 0) {
        [AWUser saveSocreInBackground:point block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                //NSLog(@"保存得到的积分 ... %d", total);
            }
        }];
    }
    
    NSLog(@"花费积分成功");
}
- (void)awardSuccess:(NSNotification *)noti
{
    int point = [[[noti valueForKey:@"object"] valueForKey:@"point"] intValue];
    NSString *appname = [[noti valueForKey:@"object"] valueForKey:@"appname"];
    if (point > 0) {
        [AWUser saveScoreRecordInBackground:ZHIMENGNAME appname:appname socre:point block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSString *msg = [NSString stringWithFormat:@"%@ 得到%d的%@",DOMOBTITLE,point,AdvertiseWallUnit];
                [Utility registerLocalNotificationTitle:DOMOBNAME body:msg];
            }
        }];
        
        PointManager *manager = [[ZhiMengWallManagerImp alloc] init];
        [manager consume:point];
    }
    
    NSLog(@"奖励积分成功");
}
- (void)updataFailed:(NSNotification *)noti
{
    int value = [[[noti valueForKey:@"object"] valueForKey:@"value"] intValue];
    switch (value) {
        case 1:
            NSLog(@"查询积分失败");
            break;
        case 2:
            NSLog(@"花费积分失败");
            break;
        case 3:
            NSLog(@"赚取积分失败");
            break;
        default:
            break;
    }
}
- (void)configSuccess:(NSNotification *)noti
{
    NSString *config = [[noti valueForKey:@"object"] valueForKey:@"configParam"];
    NSLog(@"获取在积分墙开关 = %@",config);
}
- (void)configFailed:(NSNotification *)noti
{
    NSLog(@"获取积分墙开关失败");
}
#pragma ZhiMeng End
// register remote push token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DataShare *share = [DataShare shareInstance];
    NSString *token = [deviceToken description];
    [share setdeviceToken:token];
    
    //推送功能打开时, 注册当前的设备, 同时记录用户活跃, 方便进行有针对的推送
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    //可选 但是很重要. 我们可以在任何地方给currentInstallation设置任意值,方便进行有针对的推送
    //比如如果我们知道用户的年龄了,可以加上下面这一行 这样推送时我们可以选择age>20岁的用户进行通知
    //[currentInstallation setObject:@"28" forKey:@"age"];
    
    //我们当然也可以设置根据地理位置提醒 发挥想象力吧!

    //当然别忘了任何currentInstallation的变更后做保存
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //点击提示框的打开
    NSLog(@"application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification");
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message:notification.alertAction message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//    [alert release];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    // 要进入后台
    NSLog(@"applicationWillResignActive  ...");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //进入后台
    NSLog(@"applicationDidEnterBackground  ...");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //进入前台
    NSLog(@"applicationWillEnterForeground  ...");
    
    [UserPointManager updatePointMgr];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 后台进来 清理通知标识
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"applicationWillTerminate  ...");
}

- (void)dealloc
{
    [hostReach release];
    [super dealloc];
}

@end
