//
//  YoumiWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "YoumiWallManagerImp.h"
#import "YouMiPointsManager.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "AppConfig.h"
#import "Utility.h"

@interface YoumiWallManagerImp () {
    
}

@end

@implementation YoumiWallManagerImp

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

- (void)addSocre:(NSUInteger) point {
    [YouMiPointsManager rewardPoints:point];
}

//读取所有积分并清空
- (void)consume:(NSUInteger) point {
    [YouMiPointsManager spendPoints:point];
}

//检查积分
- (void)checkSocre {
    [YouMiPointsManager checkPoints];
    int *socre = [YouMiPointsManager pointsRemained];
    int i = socre[0];
    
    NSLog(@"check socre ... %d",i);
}
//检测状态
- (void)checkStatus {
    NSLog(@"GuoMob updatePoint ...");
    [YouMiPointsManager checkPoints];
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    [YouMiPointsManager checkPoints];
}

@end
