//
//  ZKcmWallManagerImp.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-8.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "PointManager.h"

@interface ZKcmWallManagerImp : PointManager

- (void)addSocre:(NSUInteger) point;
- (void)consume:(NSUInteger) point;
- (void)updateSocre;
- (void)checkSocre;
- (void)checkStatus;

- (void)checkSocreWithSave;

@end
