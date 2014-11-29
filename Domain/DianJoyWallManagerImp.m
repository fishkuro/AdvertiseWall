//
//  DianJoyWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DianJoyWallManagerImp.h"
#import "JJSDK.h"
#import "JJDiamondConstants.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "AppConfig.h"
#import "Utility.h"

@interface DianJoyWallManagerImp ()<JJSDKDelegate> {
    
}

@end

@implementation DianJoyWallManagerImp

- (id)init
{
    if (self = [super init]) {
        [JJSDK setDelegate:self];
    }
    
    return self;
}

- (void)dealloc
{
    [JJSDK setDelegate:nil];
    
    [super dealloc];
}

- (void)addSocre:(NSUInteger) point
{
    [JJSDK awardJJPoints:point];
}

- (void)consume:(NSUInteger) point
{
    [JJSDK spendJJPoints:point];
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
    [JJSDK getUserJJPoints];
}

#pragma mark - DianJoySdkDelegate methods
- (void)getUserJJPointsFail:(NSError *)error
{
    NSString *errorInfo = [NSString stringWithFormat:@"DianJoyWallManager getUserJJPointsFail - %@",error];
    [AWUser postErrorLogInBackground:errorInfo errortype:@"积分查询"];
}

- (void)getUserJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
    NSLog(@"getUserDianPointsSuccess");
//    NSString *labelString= [NSString stringWithFormat:@"%d || %@",dianPointsAmounts,currencyName];
//    self.pointsLabel.text = labelString;
    if (dianPointsAmounts > 0) {
        [self consume:dianPointsAmounts];
    }
}
- (void)spendJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
//    NSLog(@"spendDianPointsSuccess");
//    NSString *labelString= [NSString stringWithFormat:@"%d%@",dianPointsAmounts,currencyName];
//    self.pointsLabel.text = labelString;
    
    [AWUser saveSocreInBackground:dianPointsAmounts block:^(BOOL succeeded, NSError *error) {
        //NSLog(@"消费得到的积分 ... %d", dianPointsAmounts);
        [AWUser saveScoreRecordInBackground:DIANJOYNAME socre:dianPointsAmounts block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSString *msg = [NSString stringWithFormat:@"%@ 得到%d的%@",DIANJOYTITLE,dianPointsAmounts,AdvertiseWallUnit];
                [Utility registerLocalNotificationTitle:DIANJOYNAME body:msg];
            }
        }];
    }];
}
- (void)spendJJPointsFail:(NSError *)error
{
    NSLog(@"spendDianPointsFail");
    
    NSString *errorInfo = [NSString stringWithFormat:@"DianJoyWallManager spendJJPointsFail - %@",error];
    [AWUser postErrorLogInBackground:errorInfo errortype:@"消费积分"];
}
- (void)awardJJPointsFail:(NSError *)error
{
    NSLog(@"awardDianPointsFail");
}
- (void)awardJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
//    NSLog(@"awardDianPointsSuccess");
//    NSString *labelString= [NSString stringWithFormat:@"%d%@",dianPointsAmounts,currencyName];
//    self.pointsLabel.text = labelString;
}

@end
