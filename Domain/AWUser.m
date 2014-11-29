//
//  AWUser.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-31.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AWUser.h"
#import "MemberInfo.h"
#import "ScoreRecord.h"
#import "DepositRecord.h"
#import "ErrorLogs.h"
#import "DataShare.h"
#import "AppConfig.h"
#import "WebService.h"
#import "Utility.h"

@interface AWUser() {
    
}

@property (nonatomic,retain) NSString *memberId;
@property (nonatomic,retain) AVUser   *avUser;

- (void)loadData;

@end

@implementation AWUser

@synthesize username,memberId,avUser;

- (void)loadData
{
    avUser = [AVUser currentUser];
    if (avUser) {
        self.username = avUser.username;
        self.memberId = [avUser objectForKey:@"memberId"];
        
        DataShare *share = [DataShare shareInstance];
        share.userid = self.memberId;
        share.username = self.username;
    }
}

- (id)currentMemberInfo
{
    AVQuery *query = [MemberInfo query];
    [query whereKey:@"objectId" equalTo:self.memberId];
    NSArray *objects = [query findObjects];
    MemberInfo *rlt = [objects objectAtIndex:0];
    
    return rlt;
}

- (void)dealloc
{
    [super dealloc];
}

+ (id)currentUser
{
    AWUser *user = [[[AWUser alloc] init] autorelease];
    [user loadData];
    
    return user;
}

+ (void)initLocalInfo:(NSUserDefaults *) document
{
    NSLog(@" --- initLocalInfo --- ");
    
    //object
    NSString *o_username = @"normal";
    NSString *o_password = @"123456";
    NSNumber *o_autologin = [NSNumber numberWithBool:false];
    
    NSLog(@"initLocalInfo : %@",o_autologin);
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:o_username forKey:LOCALUSERNAMEKEY];
    [dictionary setObject:o_password forKey:LOCALPASSWORDKEY];
    [dictionary setObject:o_autologin forKey:LOCALAUTOLOGINKEY];
    
    [document registerDefaults:dictionary];
    //save to disk
    [document synchronize];
}

+ (void)loadLocalInfo:(NSUserDefaults *) document
{
    NSLog(@" --- loadLocalInfo --- ");
    
    NSString *o_username = [document objectForKey:LOCALUSERNAMEKEY];
    NSString *o_password = [document objectForKey:LOCALPASSWORDKEY];
    NSNumber *o_autologin = [document objectForKey:LOCALAUTOLOGINKEY];
    
    NSLog(@"loadLocalInfo : %@",o_autologin);
    
    DataShare *share = [DataShare shareInstance];
    share.username = o_username;
    share.password = o_password;
    share.autologin = [o_autologin boolValue];
}

+ (void)localInfoDefault
{
    NSUserDefaults *userDocument = [NSUserDefaults standardUserDefaults];
    NSString *userData = [userDocument objectForKey:LOCALUSERNAMEKEY];
    
    NSLog(@"localInfoDefault : %@",userData);
    if (!userData || [userData isEqualToString:@""]) {
        [self initLocalInfo:userDocument];
    }
    else {
        [self loadLocalInfo:userDocument];
    }
}

+ (void)localInfoUpdate:(NSString *)username password:(NSString *)password autoLogin:(BOOL)login
{
    NSString *o_username = username;
    NSString *o_password = password;
    NSNumber *o_autologin = [NSNumber numberWithBool:login];
    NSUserDefaults *document = [NSUserDefaults standardUserDefaults];
    [document setObject:o_username forKey:LOCALUSERNAMEKEY];
    [document setObject:o_password forKey:LOCALPASSWORDKEY];
    [document setObject:o_autologin forKey:LOCALAUTOLOGINKEY];
    
    //save to disk
    [document synchronize];
}

//+ (void)localInfoWithAutoLoginBlock:(AVUserResultBlock)block
//{
//
//}

+ (void)asyncGetIpAddress
{
    NSLog(@" --- WebService alloc init ...");
    WebService *websvc = [[WebService alloc] init];
    [websvc asyncGetIpAddress];
    [websvc release];
}

+ (void)logout
{
    DataShare *share = [DataShare shareInstance];
    share.autologin = false;
    [AWUser localInfoUpdate:share.username password:share.password autoLogin:false];
    
    [AVUser logOut];
}

+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(AVUserResultBlock)block
{
    DataShare *share = [DataShare shareInstance];
    NSString *ipStr = share.ipAddress;
    NSDictionary *parameters = @{@"username":username,@"password":password,@"ipaddress":ipStr};
    
    [AVCloud setProductionMode:NO];
    [AVCloud callFunctionInBackground:@"memberLogin" withParameters:parameters block:^(id object, NSError *error) {
        NSString *rltStr = object;
        if ([rltStr isEqualToString:@"登录成功"]) {
            if (object) {
                share.username = username;
                share.password = password;
                share.autologin = true;
                [AWUser localInfoUpdate:share.username password:share.password autoLogin:true];
                
                [AVUser logInWithUsernameInBackground:username password:password block:block];
            }
        }
    }];
}

+ (void)registerWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(AVIdResultBlock)block
{
    DataShare *share = [DataShare shareInstance];
    NSString *tokenStr = [share getdeviceToken];
    
    NSString *ipStr = share.ipAddress;
    NSDictionary *parameters = @{@"username":username,@"password":password,@"devicetoken":tokenStr,@"ipaddress":ipStr};
    
    [AVCloud setProductionMode:AVCloudProductionMode];
    [AVCloud callFunctionInBackground:@"memberRegister" withParameters:parameters block:block];
}

+ (void)addSubAccountWithUsernameInBackground:(NSString *) username password:(NSString *) password block:(AVIdResultBlock)block
{
    DataShare *share = [DataShare shareInstance];
    NSString *tokenStr = [share getdeviceToken];
    NSString *ipStr = share.ipAddress;
    NSDictionary *parameters = @{@"username":username,@"password":password,@"devicetoken":tokenStr,@"ipaddress":ipStr};
    
    [AVCloud setProductionMode:AVCloudProductionMode];
    [AVCloud callFunctionInBackground:@"addSubAccount" withParameters:parameters block:block];
}

+ (void)postFeedBackWithUserinfoInCloud:(NSString *)title content:(NSString *)content block:(AVIdResultBlock)block;
{
    DataShare *share = [DataShare shareInstance];
    NSString *userid = share.userid;
    NSString *username = share.username;
    NSString *ipStr = share.ipAddress;
    NSDictionary *parameters = @{@"userid":userid,@"username":username,@"ftitle":title,@"fcontent":content,@"ipaddress":ipStr};
    
    NSLog(@" -- parms -- :  %@",parameters);
    
    [AVCloud setProductionMode:AVCloudProductionMode];
    [AVCloud callFunctionInBackground:@"addFeedBack" withParameters:parameters block:block];
}

+ (void)postAccountInfoInBackground:(NSString *)moblie qq:(NSString *)qq alipay:(NSString *)alipay nickname:(NSString *)nickname mail:(NSString *)mail block:(AVBooleanResultBlock)block
{
    DataShare *share = [DataShare shareInstance];
    MemberInfo *memberInfo = [MemberInfo objectWithoutDataWithObjectId:share.userid];
    memberInfo.moblie = moblie;
    memberInfo.qq = qq;
    memberInfo.alipay = alipay;
    memberInfo.nickname = nickname;
    memberInfo.mail = mail;
    
    [memberInfo saveInBackgroundWithBlock:block];
}

+ (void)saveScoreRecordInBackground:(NSString *)terracename socre:(NSInteger)socre block:(AVBooleanResultBlock) block
{
    DataShare *share = [DataShare shareInstance];
    NSString *userid = share.userid;
    NSString *username = share.username;
    NSString *ipStr = share.ipAddress;
    NSDate *date = [Utility localDate];
    ScoreRecord *record = [ScoreRecord object];
    
    record.recordtime = date;
    record.userid = userid;
    record.username = username;
    record.terracename = terracename;
    record.adpoint = [NSNumber numberWithInteger:socre];
    record.recordip = ipStr;
    
    [record saveInBackground];
}

+ (void)saveScoreRecordInBackground:(NSString *)terracename appname:(NSString *)appname socre:(NSInteger)socre block:(AVBooleanResultBlock) block
{
    DataShare *share = [DataShare shareInstance];
    NSString *userid = share.userid;
    NSString *username = share.username;
    NSString *ipStr = share.ipAddress;
    NSDate *date = [Utility localDate];
    ScoreRecord *record = [ScoreRecord object];
    
    record.recordtime = date;
    record.userid = userid;
    record.username = username;
    record.terracename = terracename;
    record.appname = appname;
    record.adpoint = [NSNumber numberWithInteger:socre];
    record.recordip = ipStr;
    
    [record saveInBackground];
}

+ (void)postDespoitRecordInfoInBackground:(NSString *)payconduitId payname:(NSString *)payname realname:(NSString *)realname accountname:(NSString *)accountname drawvalue:(int) value block:(AVBooleanResultBlock) block
{
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    int leaveVal = [memberInfo.point intValue] / 100;
    if (value > 0 && value <= leaveVal) {
        AVObject *payconduit = [AVObject objectWithClassName:@"PayConduit"];
        payconduit.objectId = payconduitId;
        DepositRecord *despoit = [DepositRecord object];
        [despoit setObject:memberInfo forKey:@"userid"];
        [despoit setObject:memberInfo.username forKey:@"username"];
        [despoit setObject:payconduit forKey:@"payconduitid"];
        [despoit setObject:payname forKey:@"payname"];
        [despoit setObject:realname forKey:@"realname"];
        [despoit setObject:accountname forKey:@"payaccount"];
        [despoit setObject:[NSNumber numberWithInt:value] forKey:@"payvalue"];
        [despoit setObject:[NSNumber numberWithInt:0] forKey:@"payvaild"];
        
        NSDate *date = [Utility localDate];
        [despoit setObject:date forKey:@"applytime"];
        
        [despoit saveInBackgroundWithBlock:block];
    }
}

+ (void)saveSocreInBackground:(NSInteger) socre block:(AVBooleanResultBlock) block
{
    if (socre > 0) {
        MemberInfo *memberinfo = [[AWUser currentUser] currentMemberInfo];
        NSInteger point = [memberinfo.point integerValue] + socre;
        memberinfo.point = [NSNumber numberWithInteger:point];
        [memberinfo saveInBackgroundWithBlock:block];
    }
}

+ (void)postErrorLogInBackground:(NSString *)error errortype:(NSString *) errorname;
{
    ErrorLogs *logs = [ErrorLogs object];
    logs.errorname = errorname;
    logs.errorinfo = error;
    [logs saveInBackground];
}

@end