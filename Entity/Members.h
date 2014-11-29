//
//  Members.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-19.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Members : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *recmanid;
@property (nonatomic,retain) NSString *recmanpath;
@property (nonatomic,assign) int      recmantotail;

@end
