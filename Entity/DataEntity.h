//
//  DataEntity.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-26.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
//
//#endif
#import <Foundation/Foundation.h>

#import "Members.h"
#import "MemberInfo.h"
#import "Notices.h"
#import "ScoreRecord.h"
#import "ScoreTotail.h"
#import "DepositRecord.h"
#import "DespoitTotail.h"
#import "PayConduit.h"
#import "Terraces.h"
#import "Tasks.h"
#import "ErrorLogs.h"
#import "AWUser.h"

@interface DataEntity : NSObject

+ (void)registerSubClass;

@end
