//
//  MarqueeBarView.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "MarqueeBarView.h"
#import "ScreenManager.h"

@implementation MarqueeBarView

@synthesize contentLabel;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    
    return self;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self initView];
//    }
//    return self;
//}

- (void)initView
{
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    //[self setClipsToBounds:YES];
    //[self setOpaque:YES];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.contentLabel setText: @"Marquee Text"];
    [self.contentLabel setTextColor:[UIColor blackColor]];
    [self.contentLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentLabel setNumberOfLines:1];
    [self.contentLabel setOpaque:YES];
    
    [self addSubview:self.contentLabel];
}

- (void)start
{
    if (!self.viewForBaselineLayout) {
        [self initView];
    }
    
    [self startAnimation];
}

- (void)stop
{
    [UIView setAnimationsEnabled:NO];
}

- (void)startAnimation
{
    CGRect winSize = [ScreenManager mainScreenSize];
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = winSize.size.width;
    [self setFrame:viewFrame];
    
    [UIView beginAnimations:@"MarqueeBarAniamation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    
    viewFrame = self.frame;
    viewFrame.origin.x = -winSize.size.width * 2;
    [self setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CGRect winSize = [ScreenManager mainScreenSize];
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = winSize.size.width;
    [self setFrame:viewFrame];
    
    [self startAnimation];
}

- (void)dealloc
{
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
