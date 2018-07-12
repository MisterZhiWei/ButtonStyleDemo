//
//  ViewController.m
//  ButtonStyleDemo
//
//  Created by 刘志伟 on 2017/6/16.
//  Copyright © 2017年 刘志伟. All rights reserved.
//

#import "ViewController.h"
#import "MCButton.h"
#import "MCTextLayer.h"

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

    MCTextLayer *textLayer = [[MCTextLayer alloc] initWithFrame:CGRectMake(0, 200, 340, 100)];
    textLayer.text = @"层通常用于提供视图的后备但也可以用于没有显示内容的视图。一个层的主要工作是管理你提供的视觉内容，但是层本身可以设置可视属性，例如背景颜色、边框和阴影。除了管理视觉内容之外，该层还维护关于其内容的几何信息（如其位置、大小和变换），用于在屏幕上呈现该内容。修改该层的属性是如何在该层的内容或几何形状上启动动画。层对象通过采用分层定义协议来封装层及其动画的持续时间和起搏，该协议定义了层的时序信息。";
    textLayer.numberOfLines = 2;
    [self.view.layer addSublayer:textLayer];
}

@end
