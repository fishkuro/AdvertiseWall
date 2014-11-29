//
//  Tasks.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-26.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
@class Terraces;

@interface Tasks : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString *taskname;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *taskpoint;
@property (nonatomic,assign) NSNumber *enable;
@property (nonatomic,retain) Terraces *parent;

@end