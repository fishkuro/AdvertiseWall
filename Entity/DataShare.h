//
//  DataShare.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-5.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MemberInfo.h"

@interface DataShare : NSObject

//@property(nonatomic,retain) MemberInfo    *member;
@property (nonatomic,retain) NSString   *userid;
@property (nonatomic,retain) NSString   *username;
@property (nonatomic,retain) NSString   *password;
@property (nonatomic,retain) NSString   *ipAddress;
@property (nonatomic,assign) BOOL       autologin;

+ (DataShare *)shareInstance;
- (void)setdeviceToken:(NSString *) token;
- (NSString *)getdeviceToken;
+ (id)allocWithZone:(struct _NSZone *)zone;

@end
