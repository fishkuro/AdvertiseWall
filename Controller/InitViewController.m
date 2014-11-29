//
//  InitViewController.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "InitViewController.h"
#import "DKScrollingTabController.h"
#import "TaskViewController.h"

@interface InitViewController () <DKScrollingTabControllerDelegate> {
    DKScrollingTabController *superController;
}

@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 120)];
    [self.view addSubview:self.scrollView];
    NSArray *colors = @[
                        [UIColor redColor],//0
                        [UIColor yellowColor],
                        [UIColor purpleColor],
                        [UIColor greenColor],
                        [UIColor grayColor],
                        ];
    
    [colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect frame = CGRectMake(0, 0, self.scrollView.frame.size.width, 100);
        frame.origin.y = 100 * idx;
        UIView *colorView = [[UIImageView alloc] initWithFrame:frame];
        colorView.backgroundColor = obj;
        [self.scrollView addSubview:colorView];
    }];
    self.scrollView.contentSize = CGSizeMake(100,100*colors.count);
    
    //example controller using SelectionControllerDelegate
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 50)];
    self.numberLabel.font = [UIFont systemFontOfSize:50];
    self.numberLabel.text = @"0";
    [self.view addSubview:self.numberLabel];
    
    //example button to set selection control button with index 2
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 300, 200, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"Set button with index 2" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(30, 500, 200, 30);
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"btn to test" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    superController = [[DKScrollingTabController alloc] init];
    superController.delegate = self;
    
    [self addChildViewController:superController];
    [superController didMoveToParentViewController:self];
    [self.view addSubview:superController.view];
    superController.view.backgroundColor = [UIColor whiteColor];
    superController.view.frame = CGRectMake(0, 30, 320, 60);
    
    // controller customization
    superController.selectionFont = [UIFont boldSystemFontOfSize:10];
    superController.buttonInset = 50;
    superController.buttonPadding = 10;
    superController.firstButtonInset = 20;
    
    superController.translucent = YES; // experimental, this overrides background colors
    //[tabController addTopBorder:[UIColor grayColor]]; // this might be needed depending on the background view
    
    CGRect frame = superController.toolbar.frame;
    frame.size.width = 12000;
    superController.toolbar.frame = frame;
    
    //remove scroll bar
    superController.buttonsScrollView.showsHorizontalScrollIndicator = NO;
    
    //add indicator
    superController.selectedTextColor = [UIColor orangeColor];
    superController.underlineIndicator = YES; // the color is from selectedTextColor property
    
    //this has to be done after customization
    superController.selection = @[@"zero", @"one", @"two", @"three", @"four",];
}

- (void)actionBtn {
    TaskViewController *testCtr = [[TaskViewController alloc] init];
    [self.view.window addSubview:testCtr.view];
}

- (void)actionButton {
    NSLog(@"Set button with index 2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabControllerDelegate

- (void)DKScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    CGPoint scrollPoint = CGPointMake(0, selection*100);
    self.numberLabel.text = [NSString stringWithFormat:@"%lu", selection];
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    NSLog(@"Selection controller action button with index=%lu and scroll point=%@",selection, NSStringFromCGPoint(scrollPoint));
}


@end
