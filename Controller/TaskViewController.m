//
//  TaskViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "TaskViewController.h"
//#import "InitViewController.h"
#import "TaskViewCell.h"
#import "ScreenManager.h"
#import "UserPointManager.h"
#import "AppConfig.h"
#import "DataEntity.h"
#import "Utility.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
#import <AdSupport/AdSupport.h>
#endif

#import "PointManager.h"
#import "ThridSDK.h"
#import "EGORefreshTableHeaderView.h"

@interface TaskViewController() <GuoMobWallDelegate,DMOfferWallManagerDelegate,JJSDKDelegate,YJFIntegralWallDelegate,YJFCustomScoreDelegate,MyOfferAPIDelegate,SKAdWallDelegate,ZhiMengDelegate,EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    EGORefreshTableHeaderView   *refreshHeaderView;
    SKAdWallController          *adWallController;
    BOOL reloading;
}

@property (nonatomic,retain) UITableView        *tableView;
@property (nonatomic,retain) NSArray            *tasksArr;

@end

@implementation TaskViewController

- (void)loadTasks
{
    AVQuery *query = [AVQuery queryWithClassName:@"Tasks"];
    [query includeKey:@"parent"];
    [query orderByDescending:@"createdAt"];
    self.tasksArr = [query findObjects];
    
    //[UserPointManager updatePointMgr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AWUser asyncGetIpAddress];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if (refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:self.tableView.frame];
        view.delegate = self;
        [self.view insertSubview:view belowSubview:self.tableView];
        refreshHeaderView = view;
        [view release];
    }
    
    //  update the last update date
    [refreshHeaderView refreshLastUpdatedDate];
    
    // 注册登录事件消息
    ZKcmoneOWRegisterResponseEvent(ZKCMONE_ZKCM_TWO_RESPONSE_EVENTS_ZKCMT_PRESENT, self, @selector(loginSelector));
    // 注册积分墙被关闭事件消息
    ZKcmoneOWRegisterResponseEvent(ZKCMONE_ZKCM_TWO_RESPONSE_EVENTS_ZKCMT_DISMISS, self, @selector(dismissSelector));
    // 注册积分消费响应事件消息
    ZKcmoneOWRegisterResponseEvent(ZKCMONE_ZKCM_TWO_CONSUMEPTS_PT, self, @selector(ZKcmoneOWConsumepoint));
    // 注册积分墙刷新最新积分响应事件消息，使用分数的时候，开发者应该先刷新积分接口获得服务器的最新积分，再利用此分数进行相关操作
    ZKcmoneOWRegisterResponseEvent(ZKCMONE_ZKCM_TWO_REFRESH_PT, self, @selector(ZKcmoneOWRefreshPoint));
    // 注册积分墙刷新最新服务器响应事件消息
    ZKcmoneOWRegisterResponseEvent(ZKCMONE_ZKCM_TWO_SUZKCMARY_MESSAGE, self, @selector(ZKcmoneOWSummary));
    
    [JJSDK setDelegate:self];
    
    [self loadTasks];
    
//    UIButton *comSBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    comSBtn.frame = CGRectMake((winSize.size.width - 200) / 2, 70, 200, 30);
//    comSBtn.backgroundColor = [UIColor redColor];
//    [comSBtn setTitle:@"comSBtn" forState:UIControlStateNormal];
//    [comSBtn addTarget:self action:@selector(navButton_OnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:comSBtn];
    
//    UIButton *wallBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    wallBtn.frame = CGRectMake((winSize.size.width - 200) / 2, 150, 200, 30);
//    wallBtn.backgroundColor = [UIColor redColor];
//    [wallBtn setTitle:@"addSBtn" forState:UIControlStateNormal];
//    [wallBtn addTarget:self action:@selector(wallBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:wallBtn];
    
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    saveBtn.frame = CGRectMake((winSize.size.width - 200) / 2, 230, 200, 30);
//    saveBtn.backgroundColor = [UIColor redColor];
//    [saveBtn setTitle:@"saveBtn" forState:UIControlStateNormal];
//    [saveBtn addTarget:self action:@selector(saveBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:saveBtn];
    
//    UIButton *chkSBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    chkSBtn.frame = CGRectMake((winSize.size.width - 200) / 2, 300, 200, 30);
//    chkSBtn.backgroundColor = [UIColor redColor];
//    [chkSBtn setTitle:@"chkSBtn" forState:UIControlStateNormal];
//    [chkSBtn addTarget:self action:@selector(chkSBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chkSBtn];
    
//    AVQuery *query = [AVQuery queryWithClassName:@"Tasks"];
//    self.tasksArr = [query findObjects];  //单表
    
//    AVQuery *query = [AVQuery queryWithClassName:@"Tasks"];
//    [query includeKey:@"parent"];
//    self.tasksArr = [query findObjects];
    
//    for (Tasks *item in self.tasksArr) {
//        Terraces *taces = [item objectForKey:@"parent"];
//        NSLog(@"n: %@  p: %@",item.taskname,taces.terracename);
//    }
    
//    [qry findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
//        for (Tasks *item in tasks) {
//            // This does not require a network access.
//            Terraces *tces = [item objectForKey:@"parent"];
//            NSLog(@"n: %@  p: %@",item.taskname,tces.terracename);
//        }
//        self.tasksArr = tasks;
//        NSLog(@"tasksArr count: %ld",[self.tasksArr count]);
//    }];
    
    AWUser *currentUser = [AWUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        NSLog(@"云登陆识别成功！name: %@",currentUser.username);
        
        MemberInfo *memberInfo = [currentUser currentMemberInfo];
        NSLog(@"用户数据 username: %@ password: %@",memberInfo.username,memberInfo.password);
    } else {
        //缓存用户对象为空时， 可打开用户注册界面…
        NSLog(@"云登陆无法识别！");
    }
    
//    for (Terraces *item in arr) {
//        //Terraces *ttem = item.parent;
//        [query whereKey:@"parent" equalTo:item];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
//            // comments now contains the comments for myPost
//            for (Tasks *t in tasks) {
//                NSLog(@"n: %@  p: %@",t.taskname,t.parent.objectId);
//            }
//        }];
//        //NSLog(@"n: %@  p: %@",item.taskname,ttem.terracename);
//    }
}

- (void)loadView
{
    [super loadView];
    
    // 横屏 0 , 0 宽 高
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 380, 560) style:UITableViewStylePlain];
    [self.tableView setTag:kTaskScrollViewTag];
    //[_tableView setBackgroundColor:[UIColor blackColor]];
    //[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    refreshHeaderView = nil;
}

- (void)dealloc
{
    //开发者在销毁控制器的时候，注意销毁注册响应事件，否则可能会因为异步处理问题造成程序崩溃。
    ZKcmoneOWUnregisterResponseEvents(ZKCMONE_ZKCM_TWO_RESPONSE_EVENTS_ZKCMT_PRESENT | ZKCMONE_ZKCM_TWO_RESPONSE_EVENTS_ZKCMT_DISMISS|ZKCMONE_ZKCM_TWO_REFRESH_PT|ZKCMONE_ZKCM_TWO_CONSUMEPTS_PT|ZKCMONE_ZKCM_TWO_SUZKCMARY_MESSAGE);
    
    refreshHeaderView = nil;
    
    [self.tableView release];
    self.tableView = nil;

    [self.tasksArr release];
    self.tasksArr = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

//- (void)saveBtn_OnClick
//{
//    UserPointManager *manager = [[UserPointManager alloc] init];
//    [manager checkSocreWithSave];
//}

//- (void)wallBtn_OnClick
//{
//    UserPointManager *manager = [[UserPointManager alloc] init];
//    [manager addSocre:1000];

//    [wallViewCtr requestRewardWall:YES Hscreen:NO];
//    if ([[[UIDevice currentDevice] systemVersion] intValue]>=5.0) {
//        [self presentViewController:wallViewCtr animated:YES completion:nil];
//    }
//    else {
//        [self presentModalViewController:wallViewCtr animated:YES];
//    }
//}

//- (void)navButton_OnClick
//{
//    InitViewController *initViewCtr = [[InitViewController alloc] init];
//    [self.navigationController pushViewController:initViewCtr animated:YES];
//    initViewCtr = nil;
//    UserPointManager *manager = [[UserPointManager alloc] init];
//    [manager consume:1000];
//}

//- (void)chkSBtn_OnClick
//{
//    UserPointManager *manager = [[UserPointManager alloc] init];
//    [manager checkSocre];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSLog(@"Task list click no. %lu",index);
    
    Tasks *item = [self.tasksArr objectAtIndex:index];
    Terraces *terrace = [item objectForKey:@"parent"];
    NSInteger flag = [terrace.flag integerValue];
    [self pushAdWall:flag];
}

- (void)pushAdWall:(NSInteger)flag
{
    switch (flag) {
        case GUOMOBFLAG:
        {
            NSLog(@"pushAdWall GUOMOBFLAG");
            GuoMobWallViewController *guomobwall = [[GuoMobWallViewController alloc] initWithId:GuoMobAppID];
                guomobwall.delegate = self;
                guomobwall.updatetime = 30;
                guomobwall.isStatusBarHidden = NO;
            [guomobwall pushGuoMobWall:YES Hscreen:NO];
            [guomobwall release];
        }
            break;
        case DOMOBFLAG:
        {
            NSLog(@"pushAdWall DOMOBFLAG");
            DMOfferWallManager *dmofferwall = [[DMOfferWallManager alloc] initWithPublisherID:DMOfferAppID andUserID:nil];
            dmofferwall.delegate = self;
            // !!!:重要：如果需要禁用应用内下载，请将此值设置为YES。
            dmofferwall.disableStoreKit = NO;
            [dmofferwall presentOfferWallWithViewController:self type:eDMOfferWallTypeList];
            [dmofferwall release];
        }
            break;
        case YOUMIFLAG:
        {
            NSLog(@"pushAdWall YOUMIFLAG");
            [YouMiWall showOffers:YES didShowBlock:^{
                NSLog(@"有米积分墙已显示");
            } didDismissBlock:^{
                NSLog(@"有米积分墙已退出");
            }];
        }
            break;
        case MIIDIFLAG:
        {
            NSLog(@"pushAdWall MIIDIFLAG");
            [MyOfferAPI showMiidiAppOffers:self withMiidiDelegate:self];
        }
            break;
        case ADWOFLAG:
        {
            NSLog(@"pushAdWall ADWOFLAG");
            //开发者如需要后台对接，才需要设置这个字段。
            NSArray *arr = [NSArray arrayWithObjects:ZKcmone_KEY, nil];
            ZKcmoneOWSetKeywords(arr);
            // 初始化并登录积分墙
            BOOL result = ZKcmoneOWPresentZKcmtwo(ZKcmone_PID, self);
            if(!result)
            {
                NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
                NSLog(@"Initialization error, because %@", errCodeList[errCode]);
            }
            else
                NSLog(@"Initialization successfully!");
        }
            break;
        case DIANJOYFLAG:
        {
            NSLog(@"pushAdWall DIANJOYFLAG");
            [JJSDK showJJDiamondWithViewController:self];
        }
            break;
        case ESOCREFLAG:
        {
            NSLog(@"pushAdWall ESOCREFLAG");
            YJFIntegralWall *integralWall = [[YJFIntegralWall alloc] init];
            if([integralWall isScoreShow]){
                integralWall.delegate = self;
                [self presentViewController:integralWall animated:YES completion:nil];
            }
            [integralWall release];
        }
            break;
        case APPEMSFLAG:
        {
            NSLog(@"pushAdWall APPEMSFLAG");
            if (!adWallController) {
                //初始化 SKAdWallController 对象 请填写正确的广告位id
                adWallController = [[SKAdWallController alloc] initWithSKUid:AppemsAppID rootController:self];
                //设置代理
                adWallController.delegate = self;
            }
            [adWallController skAdWallPrepare];
        }
            break;
        case ZHIMENGFLAG:
        {
            [ZhiMengList showLists:self correctViewPosition:YES];
        }
            break;
        default:
            NSLog(@"pushAdWall NOFLAG");
            break;
    }
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    //  下拉刷新刷新
    reloading = YES;
    [self loadTasks];
}

- (void)doneLoadingTableViewData
{
    //  下拉刷新完成
    reloading = NO;
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma TableViewData Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasksArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    
    TaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TaskViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    NSUInteger idx = indexPath.row;
    Tasks *item = [self.tasksArr objectAtIndex:idx];
    cell.tasknameLabel.text = [NSString stringWithFormat:@"任务: %@",item.taskname];
    cell.subtitleLabel.text = item.subtitle;
    cell.taskpointLabel.text = item.taskpoint;
    cell.indexLabel.text = [NSString stringWithFormat:@"No. - %lu",idx];
    
    return cell;
}

#pragma tableview Delegate
//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"velocity. x : %f velocity. y : %f offset. x : %f offset. y : %f",velocity.x,velocity.y,targetContentOffset->x,targetContentOffset->y);
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark - GuoMob Delegate
//加载回调 返回参数YES表示加载成功 NO表示失败
- (void)loadWallAdSuccess:(BOOL)success
{
    if (success) {
        NSLog(@"积分墙加载成功");
    }
}
//加载积分墙出错时候的回调  返回错误信息
-(void)GMWallDidFailWithError:(NSString *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"加载积分墙错误提示" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alertView show];
    [alertView release];
}

//更新积分出错时候的回调  返回错误信息
-(void)GMUpdatePointError:(NSString *)error
{
    NSLog(@"刷新积分错误:%@",error);
}

#pragma GuoMob Delegate End

#pragma mark - DMOffer Delegate

// 积分墙开始加载数据
- (void)dmOfferWallManagerDidStartLoad:(DMOfferWallManager *)manager offerWallType:(DMOfferWallType)type {
    
    switch (type) {
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallDidStartLoad");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallDidStartLoad");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallDidStartLoad");
            break;
        default:
            break;
    }
}

// 积分墙加载完成。
- (void)dmOfferWallManagerDidFinishLoad:(DMOfferWallManager *)manager offerWallType:(DMOfferWallType)type {
    
    switch (type) {
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallDidFinishLoad");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallDidFinishLoad");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallDidFinishLoad");
            break;
        default:
            break;
    }
}

// 积分墙加载失败。可能的原因由error部分提供，例如网络连接失败、被禁用等。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager failedLoadWithError:(NSError *)error offerWallType:(DMOfferWallType)type {
    
    switch (type) {
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallFailedLoadWithError:%@",error);
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallFailedLoadWithError:%@",error);
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallFailedLoadWithError:%@",error);
            break;
        default:
            break;
    }
}

// 当积分墙要被呈现出来时，回调该方法
- (void)dmOfferWallManagerWillPresent:(DMOfferWallManager *)manager offerWallType:(DMOfferWallType)type {
    switch (type) {
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallWillPresent");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallWillPresent");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallWillPresent");
            break;
        default:
            break;
    }
}

//  积分墙页面关闭。
- (void)dmOfferWallManagerDidClosed:(DMOfferWallManager *)manager offerWallType:(DMOfferWallType)type {
    
    switch (type) {
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallDidClosed");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallDidClosed");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallDidClosed");
            break;
        default:
            break;
    }
}

#pragma DMOffer Delegate End

#pragma mark - YOUMI Delegate

// 获得积分
- (void)pointsGotted:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    
    int *points = [YouMiPointsManager pointsRemained];
    NSUInteger p = points[0];
    if (p > 0) {
        // 手动积分管理可以通过下面这种方法获得每份积分的信息。
        if ([YouMiPointsManager spendPoints:p]) {
            [AWUser saveSocreInBackground:p block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //NSLog(@"保存得到的积分 ... %d", i);
                    
                    NSArray *pointInfos = dict[kYouMiPointsManagerPointInfosKey];
                    NSString *appName = @"";
                    for (NSDictionary *pointInfo in pointInfos) {
                        // aPointInfo 是每份积分的信息，包括积分数，userID，下载的APP的名字
                        //NSLog(@"积分数：%@", pointInfo[kYouMiPointsManagerPointAmountKey]);
                        //NSLog(@"userID：%@", pointInfo[kYouMiPointsManagerPointUserIDKey]);
                        //NSLog(@"产品名字：%@", pointInfo[kYouMiPointsManagerPointProductNameKey]);
                        
                        // TODO 按需要处理
                        appName = pointInfo[kYouMiPointsManagerPointProductNameKey];
                    }

                    
                    [AWUser saveScoreRecordInBackground:YOUMINAME appname:appName socre:p block:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSString *msg = [NSString stringWithFormat:@"%@ 得到%lu的%@",YOUMITITLE,p,AdvertiseWallUnit];
                            [Utility registerLocalNotificationTitle:YOUMINAME body:msg];
                        }
                    }];
                }
            }];
        }
    }
    
    free(points);
}

#pragma YOUMI Delegate End

#pragma mark - ZKcmone ZKcmtwo Delegate
//登陆积分墙的代理方法
- (void)loginSelector
{
    NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
    if(errCode == ZKCMONE_ZKCM_TWO_ERRORCODE_SUCCESS)
        NSLog(@"Login successfully!");
    else
        NSLog(@"Login failed, because %@", errCodeList[errCode]);
}
//退出积分墙的代理方法
- (void)dismissSelector
{
    NSLog(@"I know, the wall is dismissed!");
}

//消费积分响应的代理方法，开发者每次消费积分之后，需要在收到此响应之后才表示完成一次消费
-(void)ZKcmoneOWConsumepoint {
    
    NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
    if(errCode == ZKCMONE_ZKCM_TWO_ERRORCODE_SUCCESS)
    {
//        UITextView *text = (UITextView*)[self.view viewWithTag:121];
//        NSInteger pRemainPoints;
//        ZKcmoneOWGetCurrentPoints(&pRemainPoints);//当收到消费积分回调后，利用此函数获得当前积分。
//        text.text = [NSString stringWithFormat:@"%ld",(long)pRemainPoints];
    }
    else
    {
//        UITextView *text = (UITextView*)[self.view viewWithTag:121];
//        text.text = [NSString stringWithFormat:@"%@",errCodeList[errCode]];
//        NSLog(@"request failed, because %@", errCodeList[errCode]);
    }
    
}

//刷新积分响应的代理方法
-(void)ZKcmoneOWRefreshPoint{
    
    NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
    if(errCode == ZKCMONE_ZKCM_TWO_ERRORCODE_SUCCESS)
    {
        //NSLog(@"ZKcmoneOWRefreshPoint successfully!");
        //UITextView *text = (UITextView*)[self.view viewWithTag:121];
        //int pRemainPoints;
        //当刷新到最新积分之后，利用此函数获得当前积分。
        //ZKcmoneOWGetCurrentPoints(&pRemainPoints);
        //text.text = [NSString stringWithFormat:@"%d",pRemainPoints];
    }
    else
        NSLog(@"refresh failed, because %@", errCodeList[errCode]);
}

//获得积分墙最新信息的代理方法
-(void)ZKcmoneOWSummary{
    
    NSInteger errCode = ZKcmoneOWFetchLatestErrorCode();
    if(errCode == ZKCMONE_ZKCM_TWO_ERRORCODE_SUCCESS)
    {
//        UITextView *text = (UITextView*)[self.view viewWithTag:121];
//        NSDictionary *dic =  ZKcmoneOWGetSummaryMessage();
//        if (dic != nil) {
//            text.text = [NSString stringWithFormat:@"%@",dic];
//        }
    }
    else
    {
//        UITextView *text = (UITextView*)[self.view viewWithTag:121];
//        text.text = [NSString stringWithFormat:@"%@",errCodeList[errCode]];
//        NSLog(@"request failed, because %@", errCodeList[errCode]);
    }
}

#pragma ZKcmone ZKcmtwo Delegate End

#pragma mark - DianJoySdk Delegate

- (void)getUserJJPointsFail:(NSError *)error
{
    NSLog(@"getUserDianPointsFail");
}
- (void)getUserJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
    NSLog(@"getUserDianPointsSuccess");
    NSString *labelString = [NSString stringWithFormat:@"%d%@",dianPointsAmounts,currencyName];
    NSLog(@"%@",labelString);
}
- (void)spendJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
    NSLog(@"spendDianPointsSuccess");
    NSString *labelString = [NSString stringWithFormat:@"%d%@",dianPointsAmounts,currencyName];
    NSLog(@"%@",labelString);
}
- (void)spendJJPointsFail:(NSError *)error
{
    NSLog(@"spendDianPointsFail");
}
- (void)awardJJPointsFail:(NSError *)error
{
    NSLog(@"awardDianPointsFail");
}
- (void)awardJJPointsSuccess:(int)dianPointsAmounts currency:(NSString *)currencyName
{
    NSLog(@"awardDianPointsSuccess");
    NSString *labelString = [NSString stringWithFormat:@"%d%@",dianPointsAmounts,currencyName];
    NSLog(@"%@",labelString);
}

#pragma DianJoySdk Delegate End

#pragma mark - Escore delegate

-(void)OpenIntegralWall:(int)_value //1 打开成功  0 获取数据失败
{
    if (_value == 1) {
        NSLog(@"积分墙打开成功");
    }
    else
    {
        NSLog(@"积分墙获取数据失败");
    }
}
-(void)CloseIntegralWall  //墙关闭
{
    NSLog(@"积分墙关闭");
}

#pragma mark - 获取积分回调
-(void)getYjfScore:(int)_score  status:(int)_value unit:(NSString *) unit// status:1 获取成功  0 获取失败
{
    if(_value == 1) {
        NSLog(@"成功得分 %d",_score);
    }
    
    NSLog(@"当前积分为：%d,获取状态：%d,单位:%@",_score,_value,unit);
}

#pragma mark - 消耗积分回调
-(void)consumptionYjfScore:(int)_score status:(int)_value//消耗积分 status:1 消耗成功  0 消耗失败
{
    NSLog(@"消耗积分为：%d,消耗状态：%d",_score,_value);
    [YJFScore getScore:self];
}

#pragma mark - Miidi SDK Delegate
// !!!: Miidi SDK 打开、关闭 回调
- (void)didMiidiShowWallView
{
    NSLog(@"米迪积分墙打开!");
}

- (void)didMiidiDismissWallView
{
    NSLog(@"米迪积分墙关闭!");
}

// !!!: Miidi SDK 积分墙数据展示成功、失败相关回调
- (void)didMiidiReceiveOffers
{
    NSLog(@"米迪积分墙数据获取成功!");
}

- (void)didMiidiFailToReceiveOffers:(NSError *)error
{
    NSLog(@"米迪积分墙数据获取失败!");
}

#pragma mark - SKAdWallDelegate
- (void)skAdWallController:(SKAdWallController *)adWallCtrl adStatus:(BOOL)adStatusNormal withMessage:(NSString *)message
{
    //判断积分墙状态
    if (adStatusNormal) {
        //展示积分墙
        [adWallCtrl skAdWallShow];
    }
    NSLog(@"%@",message);
}

- (void)skAdWallOperateScoreResultStatus:(BOOL)status userIdString:(NSString *)userIDString resultType:(ScoreResultType)resultType currentScore:(NSUInteger)score WithMessage:(NSString *)message;
{
    //积分操作是否成功
    if (status) {
        //判断结果类型
        if (resultType == SKScoreResultQuery) {
            //_scoreLabel.text = [NSString stringWithFormat:@"查询%lu",score];
            //NSLog(@"查询积分结果--用户当前积分： %d",score);
        }
        if (resultType == SKScoreResultReduce) {
            //_scoreLabel.text = [NSString stringWithFormat:@"减少%lu",score];
            //NSLog(@"减少积分结果--用户当前积分： %d",score);
        }
    }
    NSLog(@"%@",message);
}

@end
