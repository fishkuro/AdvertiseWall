//
//  DMOfferWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-7.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DMOfferWallManagerImp.h"
#import "DMOfferWallManager.h"
#import "AWUser.h"
#import "AppConfig.h"
#import "Utility.h"

@interface DMOfferWallManagerImp ()<DMOfferWallManagerDelegate> {
    DMOfferWallManager *manager;
}

@end

@implementation DMOfferWallManagerImp


- (id)init
{
    if (self = [super init]) {
        NSLog(@"Start to init DMOfferWallManager");
        manager = [[DMOfferWallManager alloc] initWithPublisherID:DMOfferAppID andUserID:nil];
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
    NSLog(@"没添加积分方法艹");
}

//消费积分
- (void)consume:(NSUInteger) point {
    [manager consumeWithPointNumber:point];
    NSLog(@"消费得到的积分 ... %lu", point);
}

//检查积分
- (void)checkSocre {
    [manager checkOwnedPoint];
}
//检测状态
- (void)checkStatus {
    NSLog(@"DMOffer checkStatus");
    [manager checkOfferWallEnableState];
}

- (void)updateSocre
{
    [manager updateUserID:DMOfferUserID];
}

- (void)checkSocreWithSave
{
    [self setLock:YES];
    
    [manager checkOwnedPoint];
}

#pragma mark - Manager Delegate

// 积分查询成功之后，回调该接口，获取总积分和总已消费积分。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager eceivedTotalPoint:(NSNumber *)totalPoint totalConsumedPoint:(NSNumber *)consumedPoint {
    
    NSInteger total = [totalPoint integerValue];
    NSInteger consume = [consumedPoint integerValue];
    
    //checkSocre
    NSLog(@"dmOfferWallManager receivedTotalPoint - total : %lu - consume : %lu",total,consume);
    
    [self consume:total];
}

// 积分查询失败之后，回调该接口，返回查询失败的错误原因。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager failedCheckWithError:(NSError *)error {
    NSLog(@"<demo>dmOfferWallManager:failedCheckWithError:%@", error);
}

// 消费请求正常应答后，回调该接口，并返回消费状态（成功或余额不足），以及总积分和总已消费积分。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager consumedWithStatusCode:(DMOfferWallConsumeStatus)statusCode
                totalPoint:(NSNumber *)totalPoint totalConsumedPoint:(NSNumber *)consumedPoint {
    
    NSInteger total = [totalPoint integerValue];
    NSInteger consume = [consumedPoint integerValue];
    
    switch (statusCode) {
        case eDMOfferWallConsumeSuccess:
            //[self.view makeToast:@"消费成功！"];
        {
            [AWUser saveSocreInBackground:total block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //NSLog(@"保存得到的积分 ... %d", total);
                    [AWUser saveScoreRecordInBackground:DOMOBNAME socre:total block:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSString *msg = [NSString stringWithFormat:@"%@ 得到%lu的%@",DOMOBTITLE,total,AdvertiseWallUnit];
                            [Utility registerLocalNotificationTitle:DOMOBNAME body:msg];
                        }
                    }];
                }
            }];
        }
            break;
        case eDMOfferWallConsumeInsufficient:
            //[self.view makeToast:@"消费失败，余额不足！"];
            break;
        case eDMOfferWallConsumeDuplicateOrder:
            //[self.view makeToast:@"订单重复！"];
            break;
        default:
            break;
    }
    
    NSLog(@"dmOfferWallManager consumedWithStatusCode - total : %lu - consume : %lu",total,consume);
}

//  消费请求异常应答后，回调该接口，并返回异常的错误原因。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager failedConsumeWithError:(NSError *)error {
    
    NSLog(@"<demo>dmOfferWallManager:failedConsumeWithError:%@", error);
}

//  积分墙是否可用。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager didCheckEnableStatus:(BOOL)enable {
    
//    self.status = enable;
    
    NSLog(@"dmOfferWallManager:didCheckEnableStatus: %i", enable);
}


@end
