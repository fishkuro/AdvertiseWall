//
//  UserPointManager.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-7.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "UserPointManager.h"
#import "DMOfferWallManagerImp.h"
#import "GuoMobWallManagerImp.h"
#import "YoumiWallManagerImp.h"
#import "ZKcmWallManagerImp.h"
#import "DianJoyWallManagerImp.h"
#import "EscoreWallManagerImp.h"
#import "MiidiWallManagerImp.h"
#import "AdWallManagerImp.h"
#import "AppemsManagerImp.h"
#import "ZhiMengWallManagerImp.h"
#import "AppConfig.h"

@interface UserPointManager () {
    PointManager    *manager;
}

@end

@implementation UserPointManager

+ (void)updatePointMgr
{
    if ([UserPointManager lockStatus]) {
        for (int i = 1 ; i < TERRACETOTAL; i++) {
            UserPointManager *manager = [[[UserPointManager alloc] initWithTagert:i] autorelease];
            [manager checkSocreWithSave];
        }
    }
}

- (id)initWithTagert:(int) flag
{
    if(self = [super init])
    {
        switch (flag) {
            case DOMOBFLAG:
                manager = [[DMOfferWallManagerImp alloc] init];
                break;
            case GUOMOBFLAG:
                manager = [[GuoMobWallManagerImp alloc] init];
                break;
            case YOUMIFLAG:
                manager = [[YoumiWallManagerImp alloc] init];
                break;
            case MIIDIFLAG:
                manager = [[MiidiWallManagerImp alloc] init];
                break;
            case ADWOFLAG:
                manager = [[ZKcmWallManagerImp alloc] init];
                break;
            case ADWALLFLAG:
                manager = [[AdWallManagerImp alloc] init];
                break;
            case DIANJOYFLAG:
                manager = [[DianJoyWallManagerImp alloc] init];
                break;
            case ESOCREFLAG:
                manager = [[EscoreWallManagerImp alloc] init];
                break;
            case APPEMSFLAG:
                manager = [[AppemsManagerImp alloc] init];
                break;
            case ZHIMENGFLAG:
                manager = [[ZhiMengWallManagerImp alloc] init];
                break;
            default:
                manager = [[PointManager alloc] init];
                break;
        }
    }
    
    return self;
}

- (void)checkSocreWithSave
{
    [manager checkSocreWithSave];
}

- (void)addSocre:(NSUInteger) point
{
    [manager addSocre:point];
}

- (void)updateSocre
{
    [manager updateSocre];
}

- (void)consume:(NSUInteger) point
{
    [manager consume:point];
}

- (void)checkSocre
{
    [manager checkSocre];
}

- (void)checkStatus
{
    [manager checkStatus];
}

+ (BOOL)lockStatus
{
    return [PointManager lockStatus];
}

- (void)dealloc {
    [manager release];
    manager = nil;
    
    [super dealloc];
}

@end