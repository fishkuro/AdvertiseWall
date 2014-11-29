//
//  DepositRecord.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-19.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface DepositRecord : AVObject<AVSubclassing>

@property (nonatomic,retain) NSString   *userid;
@property (nonatomic,retain) NSString   *username;
@property (nonatomic,retain) NSString   *payconduitid;
@property (nonatomic,retain) NSString   *payname;
@property (nonatomic,retain) NSString   *realname;
@property (nonatomic,retain) NSString   *payaccount;
@property (nonatomic,retain) NSNumber   *payvalue;  //int
@property (nonatomic,retain) NSNumber   *payvaild;  //bool
@property (nonatomic,retain) NSDate     *applytime;
@property (nonatomic,retain) NSDate     *payfortime;

@end
