//
//  Terraces.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-19.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Terraces : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString *terracename;
@property (nonatomic,retain) NSNumber *flag;

@end