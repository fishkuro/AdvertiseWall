//
//  AccountViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AccountViewController.h"
#import "ScreenManager.h"
#import "AppConfig.h"
#import "DataEntity.h"

@interface AccountViewController ()<UITextFieldDelegate> {
    
}

@property (nonatomic,strong) UITextField *moblieField;
@property (nonatomic,strong) UITextField *qqField;
@property (nonatomic,strong) UITextField *alipayField;
@property (nonatomic,strong) UITextField *nicknameField;
@property (nonatomic,strong) UITextField *mailField;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    
    CGRect winSize = [ScreenManager mainScreenSize];
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 60, 100, 30)];
    usernameLabel.font = [UIFont systemFontOfSize:13];
    usernameLabel.text = [NSString stringWithFormat:@"用户名：%@",memberInfo.username];
    [self.view addSubview:usernameLabel];
    
    UILabel *moblieLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 90, 100, 30)];
    moblieLabel.font = [UIFont systemFontOfSize:13];
    moblieLabel.text = @"手机号码：";
    [self.view addSubview:moblieLabel];
    
    self.moblieField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 120, 300, 30)];
    self.moblieField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.moblieField.layer.borderWidth = 1.0;
    self.moblieField.delegate = self;
    self.moblieField.returnKeyType = UIReturnKeyNext;
    self.moblieField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.moblieField];
    
    UILabel *qqLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 150, 100, 30)];
    qqLabel.font = [UIFont systemFontOfSize:13];
    qqLabel.text = @"QQ号码：";
    [self.view addSubview:qqLabel];
    
    self.qqField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 180, 300, 30)];
    self.qqField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.qqField.layer.borderWidth = 1.0;
    self.qqField.delegate = self;
    self.qqField.returnKeyType = UIReturnKeyNext;
    self.qqField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.qqField];
    
    UILabel *alipayLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 210, 100, 30)];
    alipayLabel.font = [UIFont systemFontOfSize:13];
    alipayLabel.text = @"支付宝：";
    [self.view addSubview:alipayLabel];
    
    self.alipayField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 240, 300, 30)];
    self.alipayField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.alipayField.layer.borderWidth = 1.0;
    self.alipayField.delegate = self;
    self.alipayField.returnKeyType = UIReturnKeyNext;
    self.alipayField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.alipayField];
    
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 270, 100, 30)];
    nicknameLabel.font = [UIFont systemFontOfSize:13];
    nicknameLabel.text = @"昵称：";
    [self.view addSubview:nicknameLabel];
    
    self.nicknameField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 300, 300, 30)];
    self.nicknameField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.nicknameField.layer.borderWidth = 1.0;
    self.nicknameField.delegate = self;
    self.nicknameField.returnKeyType = UIReturnKeyNext;
    self.nicknameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nicknameField];
    
    UILabel *mailLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 330, 100, 30)];
    mailLabel.font = [UIFont systemFontOfSize:13];
    mailLabel.text = @"邮箱：";
    [self.view addSubview:mailLabel];
    
    self.mailField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 360, 300, 30)];
    self.mailField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.mailField.layer.borderWidth = 1.0;
    self.mailField.delegate = self;
    self.mailField.returnKeyType = UIReturnKeyDone;
    self.mailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.mailField];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake((winSize.size.width - 80) / 2 - 80, winSize.size.height - 60, 80, 30);
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"Submit"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    UIButton *cencelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cencelBtn.frame = CGRectMake((winSize.size.width - 80) / 2 + 80, winSize.size.height - 60, 80, 30);
    [cencelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cencelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cencelBtn setBackgroundImage:[UIImage imageNamed:@"Submit"] forState:UIControlStateNormal];
    [cencelBtn addTarget:self action:@selector(cencelBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cencelBtn];
}

//通过触摸背景关闭键盘
- (void)closeKeyboard:(id)sender {
    [self.moblieField resignFirstResponder];
    [self.qqField resignFirstResponder];
    [self.alipayField resignFirstResponder];
    [self.nicknameField resignFirstResponder];
    [self.mailField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitBtn_OnClick
{
    if (!self.moblieField.text || !self.qqField.text || !self.alipayField.text || !self.nicknameField.text ||
        !self.mailField.text || ![self.moblieField.text isEqualToString:@""] || ![self.qqField.text isEqualToString:@""]
        || ![self.alipayField.text isEqualToString:@""] || ![self.nicknameField.text isEqualToString:@""] || ![self.mailField.text isEqualToString:@""]) {
        NSString *moblieStr = self.moblieField.text;
        NSString *qqStr = self.qqField.text;
        NSString *alipayStr = self.alipayField.text;
        NSString *nicknameStr = self.nicknameField.text;
        NSString *mailStr = self.mailField.text;
        [AWUser postAccountInfoInBackground:moblieStr qq:qqStr alipay:alipayStr nickname:nicknameStr mail:mailStr block:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)cencelBtn_OnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
