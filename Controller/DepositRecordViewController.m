//
//  DepositRecordViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "DepositRecordViewController.h"
#import "DataEntity.h"

@interface DepositRecordViewController () <UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,retain) NSArray    *depositRecArr;

@end

@implementation DepositRecordViewController

@synthesize depositRecArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    
    AVQuery *query = [AVQuery queryWithClassName:@"DepositRecord"];
    [query whereKey:@"userid" equalTo:memberInfo.objectId];
    [query whereKey:@"payvaild" equalTo:[NSNumber numberWithBool:YES]];
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
    static NSString *CellIdentifier = @"DepositRecordCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    DepositRecord *deposit = [self.depositRecArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  -  %d  -  %@",deposit.payname,[deposit.payvalue intValue],deposit.updatedAt];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //id item = self.items[indexPath.row];
    //[((TTControlCell *)cell) setControlItem:item];
}

@end
