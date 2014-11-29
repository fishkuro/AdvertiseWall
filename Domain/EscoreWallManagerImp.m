//
//  EscoreWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "EscoreWallManagerImp.h"
#import <Escore/YJFScore.h>
#import "DataEntity.h"
#import "AWUser.h"
#import "AppConfig.h"
#import "Utility.h"

@interface EscoreWallManagerImp ()<YJFIntegralWallDelegate> {
    
}

@end

@implementation EscoreWallManagerImp

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
    
}

- (void)consume:(NSUInteger) point
{
    [YJFScore consumptionScore:point delegate:self];
}

- (void)updateSocre
{
    
}

- (void)checkSocre
{
    [YJFScore getScore:self];
}

- (void)checkStatus
{
    
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    [YJFScore getScore:self];
}

#pragma mark - 获取积分回调
-(void)getYjfScore:(int)_score  status:(int)_value unit:(NSString *) unit;// status:1 获取成功  0 获取失败
{
    if(_value == 1 && _score > 0){
        [self consume:_score];
    }
    
    NSLog(@"当前积分为：%d,获取状态：%d,单位:%@",_score,_value,unit);
}

#pragma mark - 消耗积分回调
-(void)consumptionYjfScore:(int)_score status:(int)_value;//消耗积分 status:1 消耗成功  0 消耗失败
{
    if (_value == 1) {
        [AWUser saveSocreInBackground:_score block:^(BOOL succeeded, NSError *error) {
            //NSLog(@"消费得到的积分 ... %d", _score);
            [AWUser saveScoreRecordInBackground:ESOCRENAME socre:_score block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSString *msg = [NSString stringWithFormat:@"%@ 得到%d的%@",ESOCRETITLE,_score,AdvertiseWallUnit];
                    [Utility registerLocalNotificationTitle:ESOCRENAME body:msg];
                }
            }];
        }];
    }
    else
    {
        [YJFScore getScore:self];
    }
    
    NSLog(@"消耗积分为：%d,消耗状态：%d",_score,_value);
}

@end
