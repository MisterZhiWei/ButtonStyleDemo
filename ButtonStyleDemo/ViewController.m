//
//  ViewController.m
//  ButtonStyleDemo
//
//  Created by 刘志伟 on 2017/6/16.
//  Copyright © 2017年 刘志伟. All rights reserved.
//

#import "ViewController.h"
#import "MCButton.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark 私有方法
- (void)initSubViews{

    MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    button.buttonStyle = imageBottom;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:@"测试按钮" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"点评_icon_评论"] forState:UIControlStateNormal];

    [self.view addSubview:button];
    
}

@end
