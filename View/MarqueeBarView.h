//
//  MarqueeBarView.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeBarView : UIView {
    
}

@property (nonatomic,retain) UILabel *contentLabel;

- (void)start;
- (void)stop;

@end
