//
//  ViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ViewController.h"
#import "AppConfig.h"

@interface ViewController ()<UITabBarControllerDelegate>

@end

@implementation ViewController

+ (UITabBarController *)RootViewController
{
    UITabBarController *tabBarCtr = [[[UITabBarController alloc] init] autorelease];
    
    InitViewController *initCtr = [[[InitViewController alloc] init] autorelease];
    initCtr.title = INITTITLESTRING;
    
    TaskViewController *taskCtr = [[[TaskViewController alloc] init] autorelease];
    UINavigationController *taskNav = [[[UINavigationController alloc] initWithRootViewController:taskCtr] autorelease];
    taskNav.navigationBar.topItem.title = TASKTITLESTRING;
    
    MemberViewController *memberCtr = [[[MemberViewController alloc] init] autorelease];
    UINavigationController *memberNav = [[[UINavigationController alloc] initWithRootViewController:memberCtr] autorelease];
    memberNav.navigationBar.topItem.title = MEMBERTITLESTRING;
    
    ExchangeViewController *exchgeCtr = [[[ExchangeViewController alloc] init] autorelease];
    UINavigationController *exchgeNav = [[[UINavigationController alloc] initWithRootViewController:exchgeCtr] autorelease];
    exchgeNav.navigationBar.topItem.title = EXCHANGETITLESTRING;
    
    SystemViewController *sysCtr = [[[SystemViewController alloc] init] autorelease];
    UINavigationController *sysNav = [[[UINavigationController alloc] initWithRootViewController:sysCtr] autorelease];
    sysNav.navigationBar.topItem.title = SYSTEMTITLESTRING;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor grayColor],UITextAttributeFont:[UIFont fontWithName:@"Marion-Italic" size:14.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeFont:[UIFont fontWithName:@"Marion-Italic" size:14.0f]} forState:UIControlStateSelected];
    
    [tabBarCtr setViewControllers:@[taskNav,memberNav,exchgeNav,sysNav]];
    
    ViewController *viewCtr = [[ViewController alloc] init];
    tabBarCtr.delegate = viewCtr;
    
    UITabBar *tabBar = tabBarCtr.tabBar;
    UITabBarItem *taskItem = [tabBar.items objectAtIndex:0];
    [taskItem setImage:[UIImage imageNamed:@"Task"]];
    [taskItem setTitle:TASKTITLESTRING];
    UITabBarItem *memberItem = [tabBar.items objectAtIndex:1];
    [memberItem setImage:[UIImage imageNamed:@"Member"]];
    [memberItem setTitle:MEMBERTITLESTRING];
    UITabBarItem *exchgeItem = [tabBar.items objectAtIndex:2];
    [exchgeItem setImage:[UIImage imageNamed:@"Exchange"]];
    [exchgeItem setTitle:EXCHANGETITLESTRING];
    UITabBarItem *SysItem = [tabBar.items objectAtIndex:3];
    [SysItem setImage:[UIImage imageNamed:@"System"]];
    [SysItem setTitle:SYSTEMTITLESTRING];
    
    return tabBarCtr;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    for (UIViewController *ctr in viewController.childViewControllers) {
        SEL method = NSSelectorFromString(@"refresh");
        if ([ctr respondsToSelector:method]) {
            [ctr performSelector:method];
        }
    }
}

+ (void)pushViewControllerToTaget:(UIViewController *)parent To:(UIViewController *) target
{
    target.hidesBottomBarWhenPushed = YES;
    [parent.navigationController pushViewController:target animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
