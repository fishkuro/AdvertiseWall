//
//  MemberViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "MemberViewController.h"
#import "ViewController.h"
#import "DataShare.h"
#import "ScreenManager.h"
#import "DataEntity.h"
#import "UserPointManager.h"
#import "MenuItem.h"

@interface MemberViewController() <UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic,strong) UILabel *pointLabel;
@property (nonatomic,strong) NSArray *memberItemArr;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect winSize = [ScreenManager mainScreenSize];
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    
    UIImage *ico = [UIImage imageNamed:@"ICO-Member"];
    UIImageView *icoView = [[UIImageView alloc] initWithImage:ico];
    [icoView setFrame:CGRectMake((winSize.size.width - 140) / 2 - 80, 75, 50, 80)];
    [self.view addSubview:icoView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 140) / 2, 70, 140, 50)];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.text = [NSString stringWithFormat:@"账户名称： %@",memberInfo.username];
    [self.view addSubview:nameLabel];

    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 140) / 2, 110, 140, 50)];
    self.pointLabel.font = [UIFont systemFontOfSize:16];
    self.pointLabel.text = [NSString stringWithFormat:@"账户积分： %lu",[memberInfo.point integerValue]];
    [self.view addSubview:self.pointLabel];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, winSize.size.width, winSize.size.height - 100) style:UITableViewStyleGrouped];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [tableView release];
    
    UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, winSize.size.height - 75, 300, 150)];
    remarkLabel.font = [UIFont systemFontOfSize:13];
    remarkLabel.numberOfLines = 0;
    remarkLabel.textAlignment = NSTextAlignmentCenter;
    remarkLabel.text = @"部分广告需广告商确认数据，可能延迟\n几个小时或隔日发放，敬请谅解。\n客服QQ：123455677";
    [self.view addSubview:remarkLabel];

    MenuItem *scitem = [MenuItem new];
    scitem.itemname = @"任务记录";
    scitem.imagename = @"ICO-Screacord";
    scitem.target = @"ScoreRecordViewController";
    
    MenuItem *deitem = [MenuItem new];
    deitem.itemname = @"兑换记录";
    deitem.imagename = @"ICO-Dereacord";
    deitem.target = @"DepositRecordViewController";
    
    MenuItem *dtitem = [MenuItem new];
    dtitem.itemname = @"兑换总榜";
    dtitem.imagename = @"ICO-Detotail";
    dtitem.target = @"DepositTotailViewController";
    
    self.memberItemArr = [NSArray arrayWithObjects:scitem,deitem,dtitem, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.pointLabel release];
    self.pointLabel = nil;
    
    [self.memberItemArr release];
    self.memberItemArr = nil;
    
    [super dealloc];
}

- (void)refresh
{
    [UserPointManager updatePointMgr];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.memberItemArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemberCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    NSUInteger index = indexPath.row;
    MenuItem *item = [self.memberItemArr objectAtIndex:index];
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
    //id item = self.items[indexPath.row];
    //[((TTControlCell *)cell) setControlItem:item];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    MenuItem *item = [self.memberItemArr objectAtIndex:index];
    id target = [[NSClassFromString(item.target) alloc] init];
    [ViewController pushViewControllerToTaget:self To:target];
}

@end
