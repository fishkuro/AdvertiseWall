//
//  WebService.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "WebService.h"
#import "DataShare.h"
#import "AppConfig.h"

@implementation WebService

- (void)asyncGetIpAddress
{
    WebServicesConnection *conn = [[WebServicesConnection alloc] init];
    if ([conn canConnect]) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", ApplicationPool,WebIpAddressMethod];
        conn.delegate = [self retain]; // 异步处理,保留当前类,用于后调用
        [conn getFromURL:[NSURL URLWithString:url]];
    }
    [conn release];
}

- (void)webServicesConnection:(WebServicesConnection *)webServicesConnection afterConnectedReturnString:(NSString *)resultStr
{
    DataShare *share = [DataShare shareInstance];
    share.ipAddress = resultStr;
    
    NSLog(@"asyncGetIpAddress : %@", resultStr);
    [self release];  // 处理完异步信息,释放当前对象
}

- (void)dealloc
{
    [super dealloc];
}

@end
