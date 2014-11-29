//
//  DepositTotailViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-5.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DepositTotailViewController.h"
#import "DataEntity.h"

@interface DepositTotailViewController () <UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,retain) NSArray    *depositRecArr;

@end

@implementation DepositTotailViewController

@synthesize depositRecArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AVQuery *query = [AVQuery queryWithClassName:@"DepositTotail"];
    query.limit = 20;
    self.depositRecArr = [query findObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.depositRecArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DepositTotailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    DespoitTotail *deposit = [self.depositRecArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@    -    %d",deposit.username,[deposit.payvaluetotail intValue]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //id item = self.items[indexPath.row];
    //[((TTControlCell *)cell) setControlItem:item];
}

@end
