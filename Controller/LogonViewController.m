//
//  LogonViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-21.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AVOSCloud/AVOSCloud.h>
#import "ViewController.h"
#import "ScreenManager.h"
#import "AppConfig.h"
#import "DataEntity.h"
#import "Utility.h"

@interface LogonViewController ()<UITextFieldDelegate> {

}

@property (nonatomic,strong) UITextField *usernameField;
@property (nonatomic,strong) UITextField *passwordField;

@end

@implementation LogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AWUser asyncGetIpAddress];
    // Do any additional setup after loading the view.
    CGRect winSize = [ScreenManager mainScreenSize];
    self.view.backgroundColor = RGBColorMake(254, 244, 227, 100);
    
    UIImage *image = [UIImage imageNamed:@"Logo"];
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((winSize.size.width - image.size.width) / 2, 50, image.size.width, image.size.height)];
    logoView.image = image;
    logoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:logoView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 120, 100, 30)];
    usernameLabel.font = [UIFont systemFontOfSize:13];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.text = @"账户：";
    [self.view addSubview:usernameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 180, 100, 30)];
    passwordLabel.font = [UIFont systemFontOfSize:13];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.text = @"密码：";
    [self.view addSubview:passwordLabel];
    
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 150, 300, 30)];
    self.usernameField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.usernameField.layer.borderWidth = 1.0;
    self.usernameField.delegate = self;
    self.usernameField.returnKeyType = UIReturnKeyNext;
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 210, 300, 30)];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.passwordField.layer.borderWidth = 1.0;
    self.passwordField.delegate = self;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.returnKeyType = UIReturnKeyGo;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordField];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake((winSize.size.width - 160) / 2, 250, 160, 40);
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    //[loginBtn.layer setMasksToBounds:YES];
    //[loginBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    //[loginBtn.layer setBorderWidth:1.0]; //边框宽度
    //CGColorRef colorref = [UIColor blueColor].CGColor;
    //[loginBtn.layer setBorderColor:colorref];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"Login"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerBtn.frame = CGRectMake((winSize.size.width - 80) / 2, winSize.size.height - 60, 80, 30);
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"Register"] forState:UIControlStateNormal];
    
    [self.view addSubview:registerBtn];
}

//通过触摸背景关闭键盘
- (void)closeKeyboard:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)loginBtn_OnClick
{
    if (self.usernameField.text || self.passwordField.text || ![self.usernameField.text isEqualToString:@""] || ![self.passwordField.text isEqualToString:@""]) {
        NSString *userStr = self.usernameField.text;
        NSString *passStr = self.passwordField.text;
        
        [AWUser logInWithUsernameInBackground:userStr password:passStr block:^(AVUser *user, NSError *error) {
            
            if (!error) {
                [self presentViewController:[ViewController RootViewController] animated:YES completion:^{
                    NSLog(@"logonBtn logic");
                }];
            }
        }];
    }
}

- (void)registerBtn_OnClick
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    RegisterViewController *registerCtr = [[RegisterViewController alloc] init];
//    [self presentViewController:registerCtr animated:YES completion:^{
//        NSLog(@"registerBtn logic");
//    }];
    
    [Utility registerLocalNotificationTitle:@"通知" body:@"顶部提示内容，通知时间到了"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
