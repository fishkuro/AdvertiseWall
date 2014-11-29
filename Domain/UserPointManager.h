//
//  UserPointManager.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-7.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointManager.h"

@interface UserPointManager : NSObject

- (id)initWithTagert:(int) flag;
- (void)addSocre:(NSUInteger) point;
- (void)consume:(NSUInteger) point;
- (void)updateSocre;
- (void)checkSocre;
- (void)checkStatus;
- (void)checkSocreWithSave;
+ (BOOL)lockStatus;

+ (void)updatePointMgr;
@end
