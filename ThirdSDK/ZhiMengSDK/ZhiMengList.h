//
//  ZhiMengList.h
//
//
//  Created by baozhou on 14-8-8.
//  Copyright (c) 2014年 baozhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZhiMengAppModel.h"
@interface ZhiMengList : NSObject

/*
 打开列表的方法
 */
+ (void)showLists:(UIViewController *)controller correctViewPosition:(BOOL)position;

/*
 
 */
+ (void)requestOpenData:(BOOL)isRecommad  currentCount:(NSInteger)count revievedBlock:(void (^)(NSArray*, NSError *))recievedBlock;


//点击下载跳转到appstore的接口
+ (void)userInstallApp:(ZhiMengAppModel *)app;

@end
