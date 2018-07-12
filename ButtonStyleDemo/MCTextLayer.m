//
//  MCTextLayer.m
//  TestCode
//
//  Created by 刘志伟 on 2018/7/9.
//  Copyright © 2018年 刘志伟. All rights reserved.
//

#import "MCTextLayer.h"
#import <CoreText/CoreText.h>
@interface MCTextLayer ()<NSCoding>

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;
@property (nonatomic, assign) CGFloat rowHeight; ///<- The height of a line.
@property (nonatomic, assign) CGRect  originalFrame; ///<- Frame at initialization.

/**
 The frame occupied by the number of lines.
 */
@property (nonatomic, assign) CGRect  linesFrame;

@end

const CGFloat kGlobalLineLeading = 5.0; ///<- line leading

@implementation MCTextLayer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [[[MCTextLayer class] alloc] init];
    self.frame = frame;
    self.originalFrame = frame;
    self.linesFrame = frame;
    [self defaultConfiguration];
    return self;
}

- (void)defaultConfiguration{
    self.textColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:17];
    self.contentsScale = [UIScreen mainScreen].scale;
    self.textAlignment = NSTextAlignmentNatural;
    self.numberOfLines = 1;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_attributedText forKey:@"attributedText"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.attributedText = [aDecoder decodeObjectForKey:@"attributedText"];
    return self;
}

- (void)setStringWithText:(NSString *)text{
    NSMutableAttributedString *mAttributedString = nil;

    if (text && text.length > 0) {
        mAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    }

    if (!mAttributedString) return;
    [mAttributedString addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:NSMakeRange(0, _text.length)];
    [mAttributedString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, _text.length)];
    [mAttributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, _text.length)];
    self.string = mAttributedString;
}

- (void)resetText{
    /**
     The following code will work if setLineBreakMode after set text or attributedText.
     */
    if (_text.length > 0) {
        self.text = _text;
    }

    if (_attributedText.length >0) {
        self.attributedText = _attributedText;
    }
}

#pragma mark setter
- (void)setText:(NSString *)text{
    if (_text == text || [_text isEqualToString:text]) return;
    _text = text.copy;
    _text = text;
    if (_text.length > 0) {
        [self setStringWithText:text];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    if (attributedText.length > 0) {
        NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
        [mAttributedString addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:NSMakeRange(0, _text.length)];
        self.string = mAttributedString;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    if (!_textColor) return;
    self.foregroundColor = _textColor.CGColor;
    [self resetText];
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    if (!_textFont) return;
    // set layer font
    CFStringRef fontName = (__bridge CFStringRef)(_textFont.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.font = fontRef;
    self.fontSize = _textFont.pointSize;
    CGFontRelease(fontRef);
    self.rowHeight = _textFont.lineHeight + kGlobalLineLeading;
    [self resetText];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    if (!_textAlignment) return;
    switch (textAlignment) {
        case NSTextAlignmentLeft:
        {
            self.alignmentMode = kCAAlignmentLeft;
        }
            break;
        case NSTextAlignmentRight:
        {
            self.alignmentMode = kCAAlignmentRight;
        }
            break;
        case NSTextAlignmentCenter:
        {
            self.alignmentMode = kCAAlignmentCenter;
        }
            break;
        case NSTextAlignmentNatural:
        {
            self.alignmentMode = kCAAlignmentNatural;
        }
            break;
        case NSTextAlignmentJustified:
        {
            self.alignmentMode = kCAAlignmentJustified;
        }
            break;
        default:
            break;
    }
    [self resetText];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode{
    _lineBreakMode = lineBreakMode;
    if (!_lineBreakMode) return;
    self.paragraphStyle.lineBreakMode = _lineBreakMode;
    [self resetText];
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines{
    if (_numberOfLines == numberOfLines) return;
    _numberOfLines = numberOfLines;

    CGFloat totalHeight = _numberOfLines * self.rowHeight;
    if (_numberOfLines == 0) {
        self.frame = self.originalFrame;
        self.linesFrame = self.frame;
        self.wrapped = YES;
    }
    else if (_numberOfLines > 1 && totalHeight < self.frame.size.height) {
        CGFloat newY = self.frame.origin.y + (self.frame.size.height-totalHeight)/2;
        self.linesFrame = CGRectMake(self.frame.origin.x, newY, self.frame.size.width, totalHeight);
        self.frame = self.linesFrame;
        self.wrapped = YES;
    }
    else {
        self.frame = self.originalFrame;
        self.linesFrame = self.frame;
        self.wrapped = NO;
    }

    [self resetText];
}

- (void)setFrame:(CGRect)frame{
    CGFloat newY = frame.origin.y - self.linesFrame.origin.y;
    frame = CGRectMake(frame.origin.x, self.linesFrame.origin.y+newY, frame.size.width, self.linesFrame.size.height);
    [super setFrame:frame];
}

#pragma mark getter
- (NSMutableParagraphStyle *)paragraphStyle{
    if (!_paragraphStyle) {
        _paragraphStyle  = [[NSMutableParagraphStyle alloc] init];
        _paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _paragraphStyle;
}


@end
