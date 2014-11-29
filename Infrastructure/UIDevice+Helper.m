//
//  UIDevice+Helper.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-29.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "UIDevice+Helper.h"

@implementation UIDevice (Helper)

+(BOOL)isJailbroken
{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}

@end
