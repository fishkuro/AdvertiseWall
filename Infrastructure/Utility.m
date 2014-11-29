//
//  Utility.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@implementation Utility

+ (void)alertMessage:(NSString *) str content:(NSString *) text target:(id) target tag:(int) tag
{
    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:str message:text delegate:target cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    msg.tag = tag;
    [msg show];
    [msg release];
}

+ (void)alertRetryMessage:(NSString *) str content:(NSString *) text target:(id) target tag:(int) tag
{
    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:str message:text delegate:target cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
    msg.tag = tag;
    [msg show];
    [msg release];
}

+ (NSDate *)localDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    
    return localDate;
}

+ (NSDate *)convertDateFromString:(NSString *) dataStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formatter dateFromString:dataStr];
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return dateStr;
}

+ (void)registerLocalNotificationTitle:(NSString *) title body:(NSString *) body
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        NSDate *now = [NSDate date];
        notification.fireDate = [now dateByAddingTimeInterval:10];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertBody = body;
        notification.alertAction = title;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        //NSDictionary *userMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"msg",@"key", nil];
        //[notification setUserInfo:userMsg];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

@end
