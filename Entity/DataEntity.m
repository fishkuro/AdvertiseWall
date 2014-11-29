//
//  DataEntity.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-26.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DataEntity.h"

@implementation DataEntity

+ (void)registerSubClass
{
    [Members registerSubclass];
    [MemberInfo registerSubclass];
    [Notices registerSubclass];
    [ScoreRecord registerSubclass];
    [ScoreTotail registerSubclass];
    [DepositRecord registerSubclass];
    [DespoitTotail registerSubclass];
    [PayConduit registerSubclass];
    [Terraces registerSubclass];
    [Tasks registerSubclass];
    [ErrorLogs registerSubclass];
}

@end
