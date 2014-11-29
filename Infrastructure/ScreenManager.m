//
//  ScreenManager.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-19.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ScreenManager.h"

@implementation ScreenManager

+ (CGRect)mainScreenSize
{
    return [[UIScreen mainScreen] bounds];
}

+ (CGRect)applicationFrame
{
    return [[UIScreen mainScreen] applicationFrame];
}

@end