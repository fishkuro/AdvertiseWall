//
//  AddSubAccountViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AddSubAccountViewController.h"
#import "ScreenManager.h"
#import "DataEntity.h"
#import "DataShare.h"
#import "Utility.h"
#import "AppConfig.h"

@interface AddSubAccountViewController () <UITextFieldDelegate> {
    
}

@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *confirmField;

@end

@implementation AddSubAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DataShare *share = [DataShare shareInstance];
    CGRect winSize = [ScreenManager mainScreenSize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *usernameLbl = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 95, 300, 30)];
    usernameLbl.font = [UIFont systemFontOfSize:16];
    usernameLbl.text = [NSString stringWithFormat:@"账户:     %@",share.username];
    [self.view addSubview:usernameLbl];
    
    UILabel *passwordLbl = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 135, 100, 30)];
    passwordLbl.font = [UIFont systemFontOfSize:16];
    passwordLbl.text = @"密码: ";
    [self.view addSubview:passwordLbl];
    
    UILabel *confirmLbl = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 205, 100, 30)];
    confirmLbl.font = [UIFont systemFontOfSize:16];
    confirmLbl.text = @"确认密码: ";
    [self.view addSubview:confirmLbl];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 165, 300, 30)];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.passwordField.layer.borderWidth = 1.0;
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.delegate = self;
    self.passwordField.returnKeyType = UIReturnKeyNext;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordField];
    
    self.confirmField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 240, 300, 30)];
    self.confirmField.secureTextEntry = YES;
    self.confirmField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.confirmField.layer.borderWidth = 1.0;
    self.confirmField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.confirmField.delegate = self;
    self.confirmField.secureTextEntry = YES;
    self.confirmField.returnKeyType = UIReturnKeyDone;
    self.confirmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.confirmField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerBtn.frame = CGRectMake((winSize.size.width - 80) / 2, 300, 80, 30);
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"添加" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"Submit"] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
    UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, winSize.size.height - 150, 300, 150)];
    remarkLabel.font = [UIFont systemFontOfSize:13];
    remarkLabel.numberOfLines = 0;
    remarkLabel.textAlignment = NSTextAlignmentCenter;
    remarkLabel.text = @"采用不同密码注册子账户，您不用再记那么多的账户\n但请别轻易忘记密码(〜￣▽￣)〜";
    [self.view addSubview:remarkLabel];
}

//通过触摸背景关闭键盘
- (void)closeKeyboard:(id)sender {
    [self.passwordField resignFirstResponder];
    [self.confirmField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerBtn_OnClick {
    if (!self.passwordField.text || !self.confirmField.text || ![self.passwordField.text isEqualToString:@""] || ![self.confirmField.text isEqualToString:@""]) {
        
        DataShare *share = [DataShare shareInstance];
        NSString *userStr = share.username;
        NSString *passStr = self.passwordField.text;
        NSString *confStr = self.confirmField.text;
        
        if ([passStr isEqualToString:confStr]) {
            [AWUser addSubAccountWithUsernameInBackground:userStr password:passStr block:^(id object, NSError *error) {
                NSString *rltStr = object;
                if ([rltStr isEqualToString:@"添加成功"]) {
                    [Utility alertMessage:@"提示" content:@"添加成功，请退出当前账户再登录" target:self tag:0];
                }
                else
                    [Utility alertMessage:@"错误提示" content:rltStr target:self tag:0];
            }];
        }
    }
}

@end
