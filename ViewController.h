//
//  ViewController.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

//#import "BaseController.h"
//#import "BaseNavigationController.h"
//#import "BaseTabBarController.h"
//#import "BaseTableController.h"
#import "LogonViewController.h"
#import "RegisterViewController.h"
#import "InitViewController.h"
#import "TaskViewController.h"
#import "MemberViewController.h"
#import "ExchangeViewController.h"
#import "SystemViewController.h"
#import "NoticesViewController.h"
#import "AddSubAccountViewController.h"
#import "ScoreRecordViewController.h"
#import "DepositRecordViewController.h"
#import "DepositTotailViewController.h"
#import "AccountViewController.h"
#import "FeedbackViewController.h"
#import "AboutAppViewController.h"

@interface ViewController : UIViewController

+ (UITabBarController *)RootViewController;
+ (void)pushViewControllerToTaget:(UIViewController *) parent To:(UIViewController *) target;

@end

