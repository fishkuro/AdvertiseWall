//
//  MemberInfo.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-4.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface MemberInfo : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString   *username;
@property (nonatomic,retain) NSString   *password;
@property (nonatomic,retain) NSNumber   *point;
@property (nonatomic,retain) NSString   *registerip;
@property (nonatomic,retain) NSString   *loginip;
@property (nonatomic,retain) NSString   *devicetoken;
@property (nonatomic,retain) NSDate     *lastlogintime;
@property (nonatomic,retain) NSDate     *registertime;
@property (nonatomic,retain) NSString   *moblie;
@property (nonatomic,retain) NSString   *qq;
@property (nonatomic,retain) NSString   *alipay;
@property (nonatomic,retain) NSString   *nickname;
@property (nonatomic,retain) NSString   *mail;

@end
