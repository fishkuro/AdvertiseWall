//
//  AppemsManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-26.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AppemsManagerImp.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "ThridSDK.h"
#import "AppConfig.h"
#import "Utility.h"

@interface AppemsManagerImp()<SKAdWallDelegate> {
    SKAdWallController *adWallController;
}

@end

@implementation AppemsManagerImp

-(id)initWithSKAdWall:(SKAdWallController *) wallCtr
{
    if (self = [super init]) {
        adWallController = wallCtr;
    }
    
    return self;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [adWallController release];
    adWallController = nil;
    
    [super dealloc];
}

- (void)addSocre:(NSUInteger) point
{
    
}

- (void)consume:(NSUInteger) point
{
    [adWallController skAdWallReduceScore:point];
}

- (void)updateSocre
{
    
}

- (void)checkSocre
{
    
}

- (void)checkStatus
{
    
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    [adWallController skAdWallQueryScore];
}

#pragma mark - SKAdWallDelegate
- (void)skAdWallController:(SKAdWallController *)adWallCtrl adStatus:(BOOL)adStatusNormal withMessage:(NSString *)message
{
    //判断积分墙状态
    if (adStatusNormal) {
        //展示积分墙
        //[adWallCtrl skAdWallShow];
    }
    NSLog(@"%@",message);
}

- (void)skAdWallOperateScoreResultStatus:(BOOL)status userIdString:(NSString *)userIDString resultType:(ScoreResultType)resultType currentScore:(NSUInteger)score WithMessage:(NSString *)message;
{
    //积分操作是否成功
    if (status) {
        //判断结果类型
        if (resultType == SKScoreResultQuery) {
            //_scoreLabel.text = [NSString stringWithFormat:@"查询%lu",score];
            //NSLog(@"查询积分结果--用户当前积分： %d",score);
        }
        if (resultType == SKScoreResultReduce) {
            //_scoreLabel.text = [NSString stringWithFormat:@"减少%lu",score];
            //NSLog(@"减少积分结果--用户当前积分： %d",score);
        }
    }
    NSLog(@"%@",message);
}

@end
