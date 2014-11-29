//
//  PointManager.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-7.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "PointManager.h"

@implementation PointManager

static BOOL batchLock = NO;

- (void)checkSocreWithSave
{
    NSLog(@"PointManager checkSocreWithSave");
}

- (void)addSocre:(NSUInteger) point
{
    NSLog(@"PointManager addSocre %lu",point);
}

- (void)consume:(NSUInteger) point
{
    NSLog(@"PointManager consume %lu",point);
}

- (void)updateSocre
{
    NSLog(@"PointManager updateSocre");
}

- (void)checkSocre
{
    NSLog(@"PointManager checkSocre");
}

- (void)checkStatus
{
    NSLog(@"PointManager checkStatus");
}

- (void)setLock:(BOOL) lock
{
    batchLock = lock;
}

+ (BOOL)lockStatus
{
    return batchLock;
}

@end