//
//  ZhiMengDelegate.h
//  ZhiMengAdSimper_banner
//
//  Created by siwei on 13-5-1.
//  Copyright (c) 2013年 siwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZhiMengBanner;

@protocol ZhiMengDelegate <NSObject>
@optional
#pragma mark - 接收到服务器请求的时候调用的方法
/*
 // 加载广告条成功后调用
 //
 // 说明:
 //      当广告条加载成功时调用该方法
 //
 */
- (void)zhiMengDidReceiveAd:(ZhiMengBanner *)adView;
/*
 // 加载广告条失败后调用
 //
 // 详解:
 //      加载广告条失败会调用该方法
 //
*/
- (void)zhiMengDidReceiveAdFailed:(ZhiMengBanner *)adView;

@end
