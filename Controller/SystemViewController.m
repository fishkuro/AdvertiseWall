//
//  SystemViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "SystemViewController.h"
#import "ViewController.h"
#import "ScreenManager.h"
#import "AWUser.h"
#import "MenuItem.h"
#import "DataShare.h"
#import "Utility.h"
#import "AppConfig.h"

@interface SystemViewController() <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
{
    
}

@property (nonatomic, strong) NSArray *categoryArr;

- (void)userLogout;

@end

@implementation SystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect winSize = [ScreenManager mainScreenSize];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, winSize.size.width, winSize.size.height - 40) style:UITableViewStyleGrouped];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [tableView release];

//    self.items = @[@"账户设置",
//                   @"修改密码",
//                   @"添加子账户",
//                   @"公告",];
    
    MenuItem *sysItem = [MenuItem new];
    sysItem.itemname = @"系统公告";
    sysItem.imagename = @"ICO-Notices";
    sysItem.target = @"NoticesViewController";
    NSArray *noticeItem = [NSArray arrayWithObjects:sysItem, nil];
    
    MenuItem *accItem = [MenuItem new];
    accItem.itemname = @"账户设置";
    accItem.imagename = @"ICO-Account";
    accItem.target = @"AccountViewController";
    
    MenuItem *fbkItem = [MenuItem new];
    fbkItem.itemname = @"问题反馈";
    fbkItem.imagename = @"ICO-Feedback";
    fbkItem.target = @"FeedbackViewController";
    
    MenuItem *abtItem = [MenuItem new];
    abtItem.itemname = @"关于";
    abtItem.imagename = @"ICO-About";
    abtItem.target = @"AboutAppViewController";
    NSArray *scoreDeposItem = [NSArray arrayWithObjects:accItem,fbkItem,abtItem, nil];
    
    MenuItem *subItem = [MenuItem new];
    subItem.itemname = @"添加子帐户";
    subItem.imagename = @"ICO-Addaccount";
    subItem.target = @"AddSubAccountViewController";
    NSArray *accautItem = [NSArray arrayWithObjects:subItem, nil];
    
    MenuItem *verItem = [MenuItem new];
    verItem.itemname = AppVersion;
    verItem.imagename = @"ICO-Version";
    verItem.target = @"appVersion";
    verItem.method = YES;
    NSArray *versionItem = [NSArray arrayWithObjects:verItem, nil];
    
    MenuItem *lgtItem = [MenuItem new];
    lgtItem.itemname = @"退出登录";
    lgtItem.imagename = @"ICO-Logout";
    lgtItem.target = @"userLogout";
    lgtItem.method = YES;
    NSArray *logoutItem = [NSArray arrayWithObjects:lgtItem, nil];
    
    self.categoryArr = [NSArray arrayWithObjects:noticeItem,scoreDeposItem,accautItem,versionItem,logoutItem, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.categoryArr release];
    self.categoryArr = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.categoryArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.categoryArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    //NSLog(@" section : %d",section);
    NSUInteger index = [indexPath row];
    //NSLog(@" index : %d",index);
    
    static NSString *CellIdentifier = @"SystemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        if (section < 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    NSArray *array = [self.categoryArr objectAtIndex:section];
    MenuItem *item = [array objectAtIndex:index];
    // Configure the cell.
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = item.itemname;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:item.imagename];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView DisplayCell");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    //NSLog(@"system click section : %d index : %d",section,index);
    
    NSArray *array = [self.categoryArr objectAtIndex:section];
    MenuItem *item = [array objectAtIndex:index];

    if (item.method) {
        SEL method = NSSelectorFromString(item.target);
        if ([self respondsToSelector:method]) {
            [self performSelector:method];
        }
    }
    else
    {
        id target = [[NSClassFromString(item.target) alloc] init];
        [ViewController pushViewControllerToTaget:self To:target];
    }
}

- (void)appVersion
{
    [Utility alertMessage:@"提示" content:AppVersion target:self tag:1];
}

- (void)userLogout
{
    [AWUser logout];
    [Utility alertMessage:@"提示" content:@"退出成功!" target:self tag:0];
}

#pragma marks -- UIAlertViewDelegate --
//ALertView即将消失时的事件
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if(alertView.tag == 0)
    {
        //退出成功!
        LogonViewController *logonCtr = [[LogonViewController alloc] init];
        [self presentViewController:logonCtr animated:YES completion:^{
            NSLog(@"userLogout logic");
        }];
    }
}

@end
