//
//  NoticesViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "NoticesViewController.h"
#import "ScreenManager.h"
#import "NoticeView.h"
#import "DataEntity.h"
#import "Utility.h"
#import "AppConfig.h"

@interface NoticesViewController () {
    
}

@end

@implementation NoticesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"NoticesViewController viewDidLoad");
    
    CGRect winSize = [ScreenManager mainScreenSize];

    //Notices
    AVQuery *query = [AVQuery queryWithClassName:@"Notices"];
    [query orderByDescending:@"createdAt"];
    query.limit = 1;
    NSError **error = nil;
    AVObject *notices = [query getFirstObject:error];
    if (!error) {
        NSString *titleStr = [notices objectForKey:@"title"];
        NSDate *date = [notices objectForKey:@"createdAt"];
        NSString *contentStr = [notices objectForKey:@"context"];
        
        NoticeView *view = [[NoticeView alloc] initFrameWithNotices:CGRectMake(0, 0, winSize.size.width, 1000) title:titleStr date:date context:contentStr];
        
        [self.view addSubview:view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
