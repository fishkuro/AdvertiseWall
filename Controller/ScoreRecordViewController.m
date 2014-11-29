//
//  ScoreRecordViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "ScoreRecordViewController.h"
#import "DataEntity.h"

@interface ScoreRecordViewController () <UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,retain) NSArray    *scoreRecArr;

@end

@implementation ScoreRecordViewController

@synthesize scoreRecArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    
    AVQuery *query = [AVQuery queryWithClassName:@"ScoreRecord"];
    [query whereKey:@"userid" equalTo:memberInfo.objectId];
    self.scoreRecArr = [query findObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scoreRecArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScoreRecordCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    ScoreRecord *scorerecord = [self.scoreRecArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  -  %d  -  %@",scorerecord.taskname,[scorerecord.adpoint intValue],scorerecord.createdAt];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //id item = self.items[indexPath.row];
    //[((TTControlCell *)cell) setControlItem:item];
}

@end
