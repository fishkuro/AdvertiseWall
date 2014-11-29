//
//  MiidiWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "MiidiWallManagerImp.h"
#import "MiidiObfuscation.h"
#import "MyOfferAPI.h"
#import "MyOfferAPIDelegate.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "AppConfig.h"
#import "Utility.h"

@interface MiidiWallManagerImp ()<MyOfferAPIDelegate> {
    
}

@end

@implementation MiidiWallManagerImp

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)addSocre:(NSUInteger) point
{
    [MyOfferAPI requestMiidiAddPoints:point withMiidiDelegate:self];
}

- (void)consume:(NSUInteger) point
{
    [MyOfferAPI requestMiidiCutPoints:point withMiidiDelegate:self];
}

- (void)updateSocre
{
    
}

- (void)checkSocre
{
    [MyOfferAPI requestMiidiGetPoints:self];
}

- (void)checkStatus
{
    
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    [MyOfferAPI requestMiidiGetPoints:self];
}

// !!!: Miidi SDK 积分墙 请求总积分 相关回调

- (void)didMiidiReceiveGetPoints:(NSInteger)totalPoints forMiidiPointName:(NSString *)pointName
{
    NSLog(@"%s", __func__);
    if (totalPoints > 0) {
        [AWUser saveSocreInBackground:totalPoints block:^(BOOL succeeded, NSError *error) {
            //NSLog(@"消费得到的积分 ... %d", totalPoints);
            [AWUser saveScoreRecordInBackground:MIIDINAME appname:pointName socre:totalPoints block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSString *msg = [NSString stringWithFormat:@"%@ 得到%lu的%@",MIIDITITLE,totalPoints,AdvertiseWallUnit];
                    [Utility registerLocalNotificationTitle:MIIDINAME body:msg];
                }
            }];
        }];
        
        [self consume:totalPoints];
    }
}

- (void)didMiidiFailReceiveGetPoints:(NSError *)error
{
    NSLog(@"%s", __func__);

    NSString *errorInfo = [NSString stringWithFormat:@"MiidiWallManager didMiidiFailReceiveGetPoints - %@",error];
    [AWUser postErrorLogInBackground:errorInfo errortype:@"积分查询"];
}

- (void)didMiidiReceiveAddPoints:(NSInteger)totalPoints
{
    NSLog(@"%s", __func__);
    NSLog(@"AddPoints : %lu", totalPoints);
}

- (void)didMiidiFailReceiveAddPoints:(NSError *)error
{
    NSLog(@"%s", __func__);
    
    NSString *errorInfo = [NSString stringWithFormat:@"MiidiWallManager didMiidiFailReceiveAddPoints - %@",error];
    [AWUser postErrorLogInBackground:errorInfo errortype:@"积分增加"];
}

- (void)didMiidiReceiveCutPoints:(NSInteger)totalPoints
{
    NSLog(@"%s", __func__);
}

- (void)didMiidiFailReceiveCutPoints:(NSError *)error
{
    NSLog(@"%s", __func__);
    
    NSString *errorInfo = [NSString stringWithFormat:@"MiidiWallManager didMiidiFailReceiveCutPoints - %@",error];
    [AWUser postErrorLogInBackground:errorInfo errortype:@"积分减少"];
}


@end
