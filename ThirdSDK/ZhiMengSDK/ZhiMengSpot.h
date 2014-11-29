//
//  Spot.h
//  ZMSpot
//
//  Created by wisdome on 13-12-11.
//  Copyright (c) 2013年 wisdome. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ZhiMengPopContentSize300x250     = 0, // 300*250  iphone and ipod touch ad size
    ZhiMengPopContentSize680x567     = 1, // 600*500  ipad ad size
} ZhiMengPopContentSize;



@interface ZhiMengSpot : NSObject
/*
 请求插播数据（插播采用预先加载的模式，添加插播广告，请预先请求插播广告数据）
 */
+ (ZhiMengSpot *)requestSpotAD:(ZhiMengPopContentSize)popSize;
/*
 显示插播数据，如果不显示则说明数据没有请求成功
 
   eg：
            [ZhiMengSpot showSpotDismiss:^{
              }];
 */
+ (BOOL)showSpotDismiss:(void (^)())dismiss;
@end
