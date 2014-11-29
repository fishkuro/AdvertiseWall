//
//  ScoreTotail.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-19.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface ScoreTotail : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString *userid;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,assign) float    scorevaluetotail;

@end
