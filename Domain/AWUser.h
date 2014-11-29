//
//  AWUser.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-31.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
@class MemberInfo;
@class ScoreRecord;

@interface AWUser : NSObject

@property (nonatomic,retain) NSString *username;

- (id)currentMemberInfo;
+ (id)currentUser;
+ (void)localInfoDefault;
+ (void)asyncGetIpAddress;
+ (void)localInfoUpdate:(NSString *)username password:(NSString *)password autoLogin:(BOOL)login;
//+ (void)localInfoWithAutoLoginBlock:(AVUserResultBlock)block;
+ (void)logout;
+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(AVUserResultBlock)block;

+ (void)registerWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(AVIdResultBlock)block;

+ (void)addSubAccountWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(AVIdResultBlock)block;

+ (void)postFeedBackWithUserinfoInCloud:(NSString *)title content:(NSString *)content block:(AVIdResultBlock)block;

+ (void)postAccountInfoInBackground:(NSString *)moblie qq:(NSString *)qq alipay:(NSString *)alipay nickname:(NSString *)nickname mail:(NSString *)mail block:(AVBooleanResultBlock) block;

+ (void)saveScoreRecordInBackground:(NSString *)terracename socre:(NSInteger)socre block:(AVBooleanResultBlock) block;

+ (void)saveScoreRecordInBackground:(NSString *)terracename appname:(NSString *)appname socre:(NSInteger)socre block:(AVBooleanResultBlock) block;

+ (void)postDespoitRecordInfoInBackground:(NSString *)payconduitId payname:(NSString *)payname realname:(NSString *)realname accountname:(NSString *)accountname drawvalue:(int)value block:(AVBooleanResultBlock)block;

+ (void)saveSocreInBackground:(NSInteger)socre block:(AVBooleanResultBlock)block;

+ (void)postErrorLogInBackground:(NSString *)error errortype:(NSString *)errorname;

@end
