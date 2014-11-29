//
//  FeedbackViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-26.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "FeedbackViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ScreenManager.h"
#import "AppConfig.h"
#import "DataEntity.h"
#import "Utility.h"

@interface FeedbackViewController ()<UITextFieldDelegate> {
    
}

@property (nonatomic,strong) UITextField *titleField;
@property (nonatomic,strong) UITextView *contentField;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect winSize = [ScreenManager mainScreenSize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:pan];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 95, 100, 30)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = @"标题：";
    [self.view addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 165, 100, 30)];
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.text = @"反馈内容：";
    [self.view addSubview:contentLabel];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 130, 300, 30)];
    self.titleField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.titleField.layer.borderWidth = 1.0;
    self.titleField.delegate = self;
    self.titleField.returnKeyType = UIReturnKeyNext;
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.titleField];
    
    self.contentField = [[UITextView alloc] initWithFrame:CGRectMake((winSize.size.width - 300) / 2, 195, 300, 90)];
    self.contentField.layer.borderColor = RGBColorMake(119, 119, 119, 100).CGColor;
    self.contentField.layer.borderWidth = 1.0;
    self.contentField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.contentField];
    
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
    [self.titleField resignFirstResponder];
    [self.contentField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitBtn_OnClick
{
    if (!self.titleField.text || !self.contentField.text || ![self.titleField.text isEqualToString:@""] || ![self.contentField.text isEqualToString:@""]) {
        NSString *titleStr = self.titleField.text;
        NSString *contentStr = self.contentField.text;
        
        NSLog(@"contentField : %@",contentStr);
        
        [AWUser postFeedBackWithUserinfoInCloud:titleStr content:contentStr block:^(id object, NSError *error) {
            if (!error) {
                NSString *rltStr = object;
                if ([rltStr isEqualToString:@"添加成功"]) {
                    [Utility alertMessage:@"提示" content:@"反馈成功" target:self tag:0];
                }
                else
                    [Utility alertMessage:@"错误提示" content:rltStr target:self tag:0];
            }
        }];
    }
}

//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)cencelBtn_OnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
