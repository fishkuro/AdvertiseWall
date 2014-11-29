//
//  DataShare.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-5.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DataShare.h"

@interface DataShare() {
    
}

@property (nonatomic,retain) NSString   *deviceToken;

@end

@implementation DataShare

//@synthesize member;
@synthesize userid,username,password,autologin,ipAddress,deviceToken;

static DataShare *sharedDataShare = nil;

- (void)setdeviceToken:(NSString *) token
{
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    self.deviceToken = token ? token : @"fbb02c6773efa8aca3ddff9be775e7ab68e70b78fc75d41ea36aa74762c05520";
}

- (NSString *)getdeviceToken
{
    return self.deviceToken;
}

+ (DataShare *)shareInstance {
    @synchronized(self)
    {
        if (sharedDataShare == nil) {
            sharedDataShare = [[self alloc] init];
        }
    }
    
    return sharedDataShare;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedDataShare == nil) {
            sharedDataShare = [super allocWithZone:zone];
            return sharedDataShare;
        }
    }
    
    return nil;
}

- (id)init
{
    if (self = [super init]) {
        //self.member = [[MemberInfo alloc] init];
    }
    
    return self;
}

@end
