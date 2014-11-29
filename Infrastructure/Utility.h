//
//  Utility.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void)alertMessage:(NSString *) str content:(NSString *) text target:(id) target tag:(int) tag;
+ (void)alertRetryMessage:(NSString *) str content:(NSString *) text target:(id) target tag:(int) tag;
+ (NSDate *)localDate;
+ (NSDate *)convertDateFromString:(NSString*) dataStr;
+ (NSString *)stringFromDate:(NSDate *) date;
+ (void)registerLocalNotificationTitle:(NSString *) title body:(NSString *) body;

@end