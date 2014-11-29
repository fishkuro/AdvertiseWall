//
//  PointManager.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-7.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class PointManager;
//typedef void (^PointResultBlock)(PointManager* mgr);
//typedef PointResultBlock AWPointResultBlock;

@interface PointManager : NSObject {
    
}

- (void)addSocre:(NSUInteger) point;
- (void)consume:(NSUInteger) point;
- (void)updateSocre;
- (void)checkSocre;
- (void)checkStatus;
- (void)checkSocreWithSave;
- (void)setLock:(BOOL) lock;
+ (BOOL)lockStatus;

@end