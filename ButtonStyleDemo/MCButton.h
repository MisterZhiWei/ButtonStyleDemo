//
//  MCButton.h
//  ButtonStyleDemo
//
//  Created by 刘志伟 on 2017/6/16.
//  Copyright © 2017年 刘志伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageStyle){
    imageTop,    // The picture is under the title.
    imageLeft,   // The picture is in the left title on the right.
    imageBottom, // The title is under the picture.
    imageRight   // The title is in the left picture on the right.
};


@interface MCButton : UIButton

@property (nonatomic, assign, readwrite) ImageStyle buttonStyle;
@property (nonatomic, assign) CGFloat    imgScale; ///<- scaling of the picture

@end
