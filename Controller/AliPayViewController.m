//
//  AliPayViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-23.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "AliPayViewController.h"
#import "ScreenManager.h"
#import "DataEntity.h"
#import "Utility.h"
#import "AppConfig.h"

@interface AliPayViewController ()<UITextFieldDelegate> {
    
}

@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *accountField;
@property (nonatomic,strong) UITextField *valueField;

@end

@implementation AliPayViewController

@synthesize payconduitId,payname;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect winSize = [ScreenManager mainScreenSize];
    MemberInfo *memberInfo = [[AWUser currentUser] currentMemberInfo];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 120) / 2 , 70, 200, 50)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"支付宝提现";
    [self.view addSubview:titleLabel];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 200) / 2 , 120, 300, 30)];
    pointLabel.font = [UIFont systemFontOfSize:13];
    pointLabel.text = [NSString stringWithFormat:@"当前积分：%ld (每100积分兑换1元)",[memberInfo.point integerValue]];
    [self.view addSubview:pointLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 150, 100, 30)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.text = @"姓名：";
    [self.view addSubview:nameLabel];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 180, 300, 30)];
    self.nameField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.nameField.layer.borderWidth = 1.0;
    self.nameField.delegate = self;
    self.nameField.returnKeyType = UIReturnKeyNext;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nameField];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 210, 100, 30)];
    accountLabel.font = [UIFont systemFontOfSize:13];
    accountLabel.text = @"账户：";
    [self.view addSubview:accountLabel];
    
    self.accountField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 240, 300, 30)];
    self.accountField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.accountField.layer.borderWidth = 1.0;
    self.accountField.delegate = self;
    self.accountField.returnKeyType = UIReturnKeyNext;
    self.accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.accountField];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 270, 100, 30)];
    valueLabel.font = [UIFont systemFontOfSize:13];
    valueLabel.text = @"金额：";
    [self.view addSubview:valueLabel];
    
    self.valueField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 300, 300, 30)];
    self.valueField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.valueField.layer.borderWidth = 1.0;
    self.valueField.delegate = self;
    self.valueField.returnKeyType = UIReturnKeyDone;
    self.valueField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.valueField];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake((winSize.size.width / 2 - 30 * 2), winSize.size.height - 100, 100, 30);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"Submit"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtn_OnClick) forControlEvents:UIControlEventTouchUpInside];
//    [submitBtn.layer setMasksToBounds:YES];
//    [submitBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//    [submitBtn.layer setBorderWidth:1.0]; //边框宽度
//    CGColorRef colorref = [UIColor blueColor].CGColor;
//    [submitBtn.layer setBorderColor:colorref];
    
    [self.view addSubview:submitBtn];
}

//通过触摸背景关闭键盘
- (void)closeKeyboard:(id)sender {
    [self.nameField resignFirstResponder];
    [self.accountField resignFirstResponder];
    [self.valueField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitBtn_OnClick
{
    if (!self.nameField.text || !self.accountField.text || !self.valueField.text || ![self.nameField.text isEqualToString:@""] || ![self.accountField.text isEqualToString:@""] || ![self.valueField.text isEqualToString:@""]) {
        NSString *nameStr = self.nameField.text;
        NSString *accountStr = self.accountField.text;
        int drawvalue = [self.valueField.text intValue];
        [AWUser postDespoitRecordInfoInBackground:payconduitId payname:payname realname:nameStr accountname:accountStr drawvalue:drawvalue block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [Utility alertMessage:@"提示" content:@"提交成功" target:self tag:0];
            }
        }];
    }
}

@end
