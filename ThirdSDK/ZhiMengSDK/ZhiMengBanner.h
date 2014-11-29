//
//  ZhiMengBanner.h
//  JZWebViewBanner
//
//  Created by wisdome on 14-4-16.
//  Copyright (c) 2014年 wisdome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiMengDelegate.h"
//  位置的定义
//  通过此参数开发者可以更方便设置广告条要显示的位置
typedef struct Position
{
    float x;
    float y;
}Position;

CG_INLINE Position
CGPositionMake(CGFloat x, CGFloat y)
{
    Position p; p.x = x; p.y = y; return p;
}
/****
 //
 // 广告条尺寸枚举（请开发者选择适应屏幕尺寸的广告条）
 //
 ****/

typedef enum {
    ZhiMengBannerContentSizeIdentifier200x50     = 0, // 200*50
    ZhiMengBannerContentSizeIdentifier320x50     = 1, // iPhone and iPod Touch ad size
    ZhiMengBannerContentSizeIdentifier200x200    = 2, //
    ZhiMengBannerContentSizeIdentifier300x250    = 3, //
    ZhiMengBannerContentSizeIdentifier468x60     = 4, //  ipad size
    ZhiMengBannerContentSizeIdentifier728x90     = 5, //  iPad size
} ZhiMengBannerContentSizeIdentifier;


@interface ZhiMengBanner : UIView

- (instancetype)initWithAdvertisingStyle:(ZhiMengBannerContentSizeIdentifier)style andPosition:(Position)position;

@property (nonatomic, assign) id <ZhiMengDelegate>zhimengDelegate;


@end
