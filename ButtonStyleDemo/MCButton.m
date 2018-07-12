//
//  MCButton.m
//  ButtonStyleDemo
//
//  Created by 刘志伟 on 2017/6/16.
//  Copyright © 2017年 刘志伟. All rights reserved.
//

#define titleFont [UIFont systemFontOfSize:17.0]

#import "MCButton.h"

@implementation MCButton
@synthesize imgScale = scale;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self imageRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageTop){
        return [self imageRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageBottom){
        return [self imageRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self imageRectWithImageLeftForContentTect:contentRect];
    }

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self titleRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageTop){
        return [self titleRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageBottom){
        return [self titleRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self titleRectWithImageLeftForContentTect:contentRect];
    }
}

#pragma mark imageTop
- (CGRect)imageRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+imageWH;;

    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}

#pragma mark imageLeft
- (CGRect)imageRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageX, inteval, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageWH+imageX, 0, titleW , CGRectGetHeight(contentRect));

    return rect;
}

#pragma mark imageBottom
- (CGRect)imageRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+titleH;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}

#pragma mark imageRight
- (CGRect)imageRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX+titleW , inteval, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));

    return rect;
}

#pragma mark Calculating the width of the title content.
- (CGFloat)widthForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat width = MAX(size.width, 30);
        CGFloat imageW = [self imageForState:UIControlStateNormal].size.width;

        // Ensure that boundaries cannot be crossed when the title and image width exceed the width of the button.
        if (width+imageW > CGRectGetWidth(contentRect)) {
            return  CGRectGetWidth(contentRect) - imageW;
        }
        return width+10;
    }
    else {
        return CGRectGetWidth(contentRect)/2;
    }
}

#pragma mark Calculating the height of the title content.
- (CGFloat)heightForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat height = MAX(size.height, 5);

        // When the title height exceeds the button`s 1/2 width.
        if (height > CGRectGetHeight(contentRect)/2) {
            return  CGRectGetHeight(contentRect)/2 ;
        }
        return height;
    }
    else {
        return CGRectGetHeight(contentRect)/2;
    }
}

@end
