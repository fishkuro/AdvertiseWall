//
//  NoticeView.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-11.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeView : UITableView

- (id)initFrameWithNotices:(CGRect)frame title:(NSString *)title date:(NSDate *)date context:(NSString *)context;

@end
