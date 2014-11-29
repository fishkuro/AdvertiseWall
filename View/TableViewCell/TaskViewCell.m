//
//  TaskViewCell.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-1.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "TaskViewCell.h"

@implementation TaskViewCell

@synthesize tasknameLabel,subtitleLabel,taskpointLabel,indexLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.tasknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -10, self.frame.size.width, 60)];
        [self.tasknameLabel setText: @"TaskName Text"];
        [self.tasknameLabel setTextColor:[UIColor blackColor]];
        [self.tasknameLabel setBackgroundColor:[UIColor clearColor]];
        [self.tasknameLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, self.frame.size.width, 40)];
        [self.subtitleLabel setText: @"SubTitle Text"];
        [self.subtitleLabel setTextColor:[UIColor blackColor]];
        [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.subtitleLabel setFont:[UIFont systemFontOfSize:12]];
        
        self.taskpointLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 45, 10, 80, 40)];
        [self.taskpointLabel setText: @"TaskPoint Text"];
        [self.taskpointLabel setTextColor:[UIColor redColor]];
        [self.taskpointLabel setBackgroundColor:[UIColor clearColor]];
        [self.taskpointLabel setFont:[UIFont systemFontOfSize:18]];
        
        self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, 0, 80, 40)];
        [self.indexLabel setText: @"Index Text"];
        [self.indexLabel setTextColor:[UIColor blueColor]];
        [self.indexLabel setBackgroundColor:[UIColor clearColor]];
        [self.indexLabel setFont:[UIFont systemFontOfSize:14]];
        
        [self.contentView addSubview:self.tasknameLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self.contentView addSubview:self.taskpointLabel];
        [self.contentView addSubview:self.indexLabel];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    //[self setFrame:CGRectMake(0, 0, 300, 100)];
    NSLog(@"-- Initialization awakeFromNib --");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
