//
//  RegisterViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-21.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AVOSCloud/AVOSCloud.h>
#import "RegisterViewController.h"
#import "LogonViewController.h"
#import "ScreenManager.h"
#import "Utility.h"
#import "DataShare.h"
#import "DataEntity.h"
#import "AppConfig.h"

@interface RegisterViewController ()<UITextFieldDelegate> {
    
}

@property (nonatomic,strong) UITextField *usernameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *confirmField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect winSize = [ScreenManager mainScreenSize];
    self.view.backgroundColor = RGBColorMake(254, 244, 227, 100);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 60) / 2 , 50, 300, 30)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"注册账户";
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLabel];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 95, 100, 30)];
    usernameLabel.font = [UIFont systemFontOfSize:13];
    usernameLabel.text = @"账户：";
    usernameLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:usernameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 155, 100, 30)];
    passwordLabel.font = [UIFont systemFontOfSize:13];
    passwordLabel.text = @"密码：";
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    
    UILabel *confirmLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 215, 100, 30)];
    confirmLabel.font = [UIFont systemFontOfSize:13];
    confirmLabel.text = @"确认密码：";
    confirmLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:confirmLabel];
    
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 120, 300, 30)];
    self.usernameField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.usernameField.layer.borderWidth = 1.0;
    self.usernameField.delegate = self;
    self.usernameField.returnKeyType = UIReturnKeyNext;
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 180, 300, 30)];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.passwordField.layer.borderWidth = 1.0;
    self.passwordField.delegate = self;
    self.passwordField.returnKeyType = UIReturnKeyNext;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordField];
    
    self.confirmField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 240, 300, 30)];
    self.confirmField.secureTextEntry = YES;
    self.confirmField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.confirmField.layer.borderWidth = 1.0;
    self.confirmField.delegate = self;
    self.confirmField.returnKeyType = UIReturnKeyDone;
    self.confirmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.confirmField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerBtn.frame = CGRectMake((winSize.size.width - 80) / 2, winSize.size.height - 60, 80, 30);
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"提交" forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"Register"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}

//通过触摸背景关闭键盘
- (void)closeKeyboard:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.confirmField resignFirstResponder];
}

- (void)registerBtn_OnClick
{
    if (!self.usernameField.text || !self.passwordField.text || !self.confirmField.text || ![self.usernameField.text isEqualToString:@""] || ![self.passwordField.text isEqualToString:@""] || ![self.confirmField.text isEqualToString:@""]) {
        NSString *userStr = self.usernameField.text;
        NSString *passStr = self.passwordField.text;
        NSString *confStr = self.confirmField.text;
        
        if ([passStr isEqualToString:confStr]) {
            [AWUser registerWithUsernameInBackground:userStr password:passStr block:^(id object, NSError *error) {
                NSString *rltStr = object;
                if ([rltStr isEqualToString:@"注册成功"]) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        NSLog(@"RegisterCtr logic");
                    }];
                }
                else
                    [Utility alertMessage:@"错误提示" content:rltStr target:self tag:0];
            }];
        }
        else
        {
            [Utility alertMessage:@"错误提示" content:@"两次密码输入不一致!" target:self tag:0];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
