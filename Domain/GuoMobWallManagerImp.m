//
//  GuoMobWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "GuoMobWallManagerImp.h"
#import "GuoMobWallViewController.h"
#import "AWUser.h"
#import "DataEntity.h"
#import "AppConfig.h"
#import "Utility.h"

@interface GuoMobWallManagerImp ()<GuoMobWallDelegate> {
    GuoMobWallViewController *manager;
}

@end

@implementation GuoMobWallManagerImp

- (id)init
{
    if (self = [super init]) {
        NSLog(@"Start to init GuoMobWallViewController");
        manager = [[GuoMobWallViewController alloc] initWithId:GuoMobAppID];
        manager.delegate = self;
    }
    
    return self;
}

- (void)dealloc {
    manager.delegate = nil;
    [manager release];
    manager = nil;
    
    [super dealloc];
}

#pragma mark - UIResponder
- (void)addSocre:(NSUInteger) point
{
    int i = 1000;
    [manager writePoint:i];
    NSLog(@"充值积分 ... %d",i);
}

//读取所有积分并清空
- (void)consume:(NSUInteger) point {
    int i = [manager readPoint];
    
    NSLog(@"消费积分 consume ... %d",i);
}

- (void)updateSocre
{
    [manager updatePoint];
}

//检查积分
- (void)checkSocre {
    int i = [manager checkPoint];
    
    NSLog(@"检查积分 ... %d",i);
}
//检测状态
- (void)checkStatus {
    NSLog(@"GuoMob updatePoint");
    [manager updatePoint];
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    int i = [manager checkPoint];
    
    NSLog(@"检查积分 ... %d",i);
//    int i = [manager readPoint];
//    [AWUser saveSocreInBackground:i block:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            //NSLog(@"保存得到的积分 ... %d", i);
//            [AWUser saveScoreRecordInBackground:GUOMOBNAME socre:i block:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    NSString *msg = [NSString stringWithFormat:@"%@ 得到%d的%@",GUOMOBTITLE,i,AdvertiseWallUnit];
//                    [Utility registerLocalNotificationTitle:GUOMOBNAME body:msg];
//                }
//            }];
//        }
//    }];
}

//服务器回调接口，自动或手动更新积分得到积分时都会回调该方法,可以只在积分point不为0的情况下提示
- (void)checkPoint:(NSString *)appname point:(int)point
{
    if (point > 0) {
        [AWUser saveScoreRecordInBackground:GUOMOBNAME appname:appname socre:point block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSString *msg = [NSString stringWithFormat:@"%@ 得到%d的%@",GUOMOBTITLE,point,AdvertiseWallUnit];
                [Utility registerLocalNotificationTitle:GUOMOBNAME body:msg];
            }
        }];
    }
}

@end
