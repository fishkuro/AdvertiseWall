//
//  Notices.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-5.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Notices : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString   *title;
@property (nonatomic,retain) NSDate     *postdate;
@property (nonatomic,retain) NSString   *context;

@end
