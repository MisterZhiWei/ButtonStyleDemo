//
//  MCTextLayer.h
//  TestCode
//
//  Created by 刘志伟 on 2018/7/9.
//  Copyright © 2018年 刘志伟. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface MCTextLayer : CATextLayer

@property(nullable, nonatomic, copy) NSString   *text; ///<- default is nil.
@property (null_resettable, nonatomic, strong) UIFont *textFont; ///<- default is nil (system font 17 plain).
@property (null_resettable, nonatomic, strong) UIColor *textColor; ///<- default is nil (text draws black).

/**
 The technique to use for aligning the text. Default is NSTextAlignmentNatural.
 Set a new value to this property also causes the new alignment to be applied to the entire `attributedText`.
 Get the value returns the alignment at the head of `attributedText`.
 */
@property (nonatomic) NSTextAlignment textAlignment;

/**
 The technique to use for wrapping and truncating the label's text.
 Default is NSLineBreakByTruncatingTail.
 */
@property (nonatomic) NSLineBreakMode lineBreakMode;

/**
 The maximum number of lines to use for rendering text. Default value is 1.
 0 means no limit.
 */
@property (nonatomic) NSUInteger numberOfLines;

/**
 default is NSTextAlignmentNatural.
 */
@property (nullable, nonatomic, copy) NSAttributedString *attributedText;

/**
 Initializes a MCTextLayer.

 @param frameRect is the frame rectangle of the MCTextLayer.

 @return An initialized MCTextLayer.
 */
- (instancetype)initWithFrame:(CGRect)frameRect;

@end
