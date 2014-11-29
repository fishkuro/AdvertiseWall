//
//  ExchangeViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ExchangeViewController.h"
#import "AliPayViewController.h"
#import "MarqueeBarView.h"
#import "DataShare.h"
#import "ScreenManager.h"
#import "DataEntity.h"
#import "UserPointManager.h"

@interface ExchangeViewController()<UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,strong) UILabel *pointLabel;
@property (nonatomic,strong) NSArray *payconduitArr;
@property (nonatomic,strong) NSArray *imagesArr;

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, winSize.size.width, winSize.size.height - 200) style:UITableViewStyleGrouped];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [tableView release];
    
    UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, winSize.size.height - 150, 300, 150)];
    remarkLabel.font = [UIFont systemFontOfSize:13];
    remarkLabel.numberOfLines = 0;
    remarkLabel.textAlignment = NSTextAlignmentCenter;
    remarkLabel.text = @"目前只开放支付宝提现，支付宝需实名认证，具体可以联系客服。\n客服QQ：123455677";
    [self.view addSubview:remarkLabel];
    
    MarqueeBarView *marqueeView = [[MarqueeBarView alloc] initWithFrame:CGRectMake((winSize.size.width - 200) / 2, 150, winSize.size.width * 2, 50)];
    [self.view addSubview:marqueeView];
    marqueeView.contentLabel.text = @"用户:kuro 提现:3000元 用户:fisw 提现:1000元 用户:dennis 提现:300元 用户:xiaow 提现:500元";
    [marqueeView start];
    
    AVQuery *query = [AVQuery queryWithClassName:@"PayConduit"];
    self.payconduitArr = [query findObjects];
    
    self.imagesArr = [NSArray arrayWithObjects:@"ICO-Alipay",@"ICO-Tenpay",@"ICO-Unionpay", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.pointLabel release];
    self.pointLabel = nil;
    
    [self.payconduitArr release];
    self.payconduitArr = nil;
    
    [self.imagesArr release];
    self.imagesArr = nil;
    
    [super dealloc];
}

- (void)refresh
{
    [UserPointManager updatePointMgr];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.payconduitArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExchangeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    NSUInteger index = indexPath.row;
    PayConduit *payconduit = [self.payconduitArr objectAtIndex:index];
    NSString *imageName = [self.imagesArr objectAtIndex:index];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = payconduit.payname;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView DisplayCell");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
        {
            PayConduit *payconduit = [self.payconduitArr objectAtIndex:index];
            AliPayViewController *payCtr = [[AliPayViewController alloc] init];
            payCtr.payconduitId = payconduit.objectId;
            payCtr.payname = payconduit.payname;
            payCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payCtr animated:YES];
            [payCtr release];
        }
            break;
            
        default:
            break;
    }
}

@end
