//
//  ZhiMengWallManagerImp.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-27.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ZhiMengWallManagerImp.h"
#import "DataEntity.h"
#import "AWUser.h"
#import "ThridSDK.h"
#import "AppConfig.h"
#import "Utility.h"

@interface ZhiMengWallManagerImp() {
    
}

@end

@implementation ZhiMengWallManagerImp

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
    [ZhiMengPointsManger awardPoints:point];
}

- (void)consume:(NSUInteger) point
{
    [ZhiMengPointsManger spendPoints:point];
}

- (void)updateSocre
{
    
}

- (void)checkSocre
{
    [ZhiMengPointsManger getPoints];
}

- (void)checkStatus
{
    
}

- (void)checkSocreWithSave
{
    [self setLock:NO];
    [ZhiMengPointsManger getPoints];
}

@end
