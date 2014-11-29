//
//  ErrorLogs.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-9.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface ErrorLogs : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString   *errorname;
@property (nonatomic,retain) NSString   *errorinfo;

@end
