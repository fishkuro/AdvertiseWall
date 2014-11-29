//
//  ZKcmWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ZKcmWallManagerImp.h"
#import "ZKcmoneZkcmtwo.h"
#import "AppConfig.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "Utility.h"

@interface ZKcmWallManagerImp () {
    
}

@end

@implementation ZKcmWallManagerImp

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)addSocre:(NSUInteger) point
{
    
}

- (void)consume:(NSUInteger) point
{
    // 消费value个虚拟货币
    if(ZKcmoneOWConsumePoints(point))
    {
        [AWUser saveSocreInBackground:point block:^(BOOL succeeded, NSError *error) {
            //NSLog(@"消费得到的积分 ... %d", point);
            [AWUser saveScoreRecordInBackground:ADWONAME socre:point block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSString *msg = [NSString stringWithFormat:@"%@ 得到%lu的%@",ADWOTITLE,point,AdvertiseWallUnit];
                    [Utility registerLocalNotificationTitle:ADWONAME body:msg];
                }
            }];
        }];
    }
//    else
//    {
//        //try agin
//        NSString *error = [NSString stringWithFormat:@"ZKcmWallManager error : %lu",point];
//        [AWUser postErrorLogInBackground:error errortype:@"消费积分"];
//        NSInteger pRemainPoints;
//        ZKcmoneOWGetCurrentPoints(&pRemainPoints);//当收到消费积分回调后，利用此函数获得当前积分。
//        if(ZKcmoneOWConsumePoints(pRemainPoints))
//        {
//            [AWUser saveSocreInBackground:pRemainPoints block:^(BOOL succeeded, NSError *error) {
//                //NSLog(@"消费得到的积分 ... %d", point);
//                [AWUser saveScoreRecordInBackground:ADWONAME socre:pRemainPoints block:^(BOOL succeeded, NSError *error) {
//                    if (succeeded) {
//                        NSString *msg = [NSString stringWithFormat:@"%@ 得到%lu的%@",ADWOTITLE,pRemainPoints,AdvertiseWallUnit];
//                        [Utility registerLocalNotificationTitle:ADWONAME body:msg];
//                    }
//                }];
//            }];
//        }
//    }
}

- (void)updateSocre
{
    ZKcmoneOWRefreshPoint();
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
    NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
    if(errCode == ZKCMONE_ZKCM_TWO_ERRORCODE_SUCCESS)
    {
        NSInteger pRemainPoints;
        ZKcmoneOWGetCurrentPoints(&pRemainPoints);//当收到消费积分回调后，利用此函数获得当前积分。
        [self consume:pRemainPoints];
    }
}

@end
