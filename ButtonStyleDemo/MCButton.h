//
//  MCButton.h
//  ButtonStyleDemo
//
//  Created by 刘志伟 on 2017/6/16.
//  Copyright © 2017年 刘志伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    imageTop = 0,   // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    imageRight,     // 图片右 标题左
} ImageStyle;


@interface MCButton : UIButton

@property (nonatomic, assign) ImageStyle buttonStyle;

@end
