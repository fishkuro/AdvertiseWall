//
//  NoticeView.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-11.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "NoticeView.h"
#import "ScreenManager.h"
#import "Utility.h"

@implementation NoticeView

- (id)initFrameWithNotices:(CGRect)frame title:(NSString *)title date:(NSDate *)date context:(NSString *)context
{
    if (self = [super initWithFrame:frame]) {
        
        UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width - 30, 50)];
        titleField.font = [UIFont systemFontOfSize:16];
        titleField.textAlignment = NSTextAlignmentCenter;
        titleField.text = title;
        [self addSubview:titleField];
        
        UITextField *dateField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + 40, frame.size.width - 30, 20)];
        dateField.font = [UIFont systemFontOfSize:11];
        dateField.textAlignment = NSTextAlignmentCenter;
        dateField.text = [NSString stringWithFormat:@"发布日期：%@",[Utility stringFromDate:date]];
        [self addSubview:dateField];
        
        UITextView *contentField = [[UITextView alloc] initWithFrame:CGRectMake(frame.origin.x + 20, frame.origin.y + 70, frame.size.width - 20, frame.size.height)];
        contentField.font = [UIFont systemFontOfSize:15];
        contentField.text = context;
        [contentField setEditable:NO];
        [self addSubview:contentField];
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    CGRect winSize = [ScreenManager mainScreenSize];
//    CGFloat grey[4] = {0.6f, 0.6f, 0.6f, 1.0f};
//    CGPoint start = CGPointMake(10, 55);
//    CGPoint end = CGPointMake(winSize.size.width - 10, 55);
//
//    [NoticeView strokeLine:grey startPoint:start endPoint:end width:1.0f];
//}

+ (void)strokeLine:(const CGFloat*)strokeColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint width:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    width = width >= 0 ? width : 1.0;
    CGContextSaveGState(context);
    CGContextSetStrokeColorSpace(context, space);
    CGContextSetStrokeColor(context, strokeColor);
    CGContextSetLineWidth(context, width);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(space);
}

@end
